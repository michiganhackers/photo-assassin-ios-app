//
//  CameraController.swift
//  PhotoAssassin
//
//  Created by Phoebe Liang on 3/14/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//
import AVFoundation
import Foundation
import UIKit

class CameraController: NSObject {
    // MARK: - UI Elements
    var captureSession: AVCaptureSession?
    var currentCameraPosition: CameraPosition?
    var frontCamera: AVCaptureDevice?
    var frontCameraInput: AVCaptureDeviceInput?
    var photoOutput: AVCapturePhotoOutput?
    var rearCamera: AVCaptureDevice?
    var rearCameraInput: AVCaptureDeviceInput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var flashMode = AVCaptureDevice.FlashMode.off
    var photoCaptureCompletionBlock: ((UIImage?, Error?) -> Void)?
}

extension CameraController {
    // MARK: - Custom Functions
    func isFront() -> Bool {
        return currentCameraPosition == .front ? true : false
    }

    func createCaptureSession() {
        self.captureSession = AVCaptureSession()
    }

    func configureCaptureDevices() throws {
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                       mediaType: AVMediaType.video,
                                                       position: .unspecified)
        let cameras = session.devices.compactMap { $0 }
        guard !cameras.isEmpty else { throw CameraControllerError.noCamerasAvailable }
        for camera in cameras {
            if camera.position == .front {
                self.frontCamera = camera
            }
            if camera.position == .back {
                self.rearCamera = camera
                try camera.lockForConfiguration()
                camera.focusMode = .continuousAutoFocus
                camera.unlockForConfiguration()
            }
        }
    }

    func configureDeviceInputs() throws {
        guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }

        if let rearCamera = self.rearCamera {
            self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
            if let rearInput = rearCameraInput, captureSession.canAddInput(rearInput) {
                captureSession.addInput(rearInput)
            }
            self.currentCameraPosition = .rear
        } else if let frontCamera = self.frontCamera {
            self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
            if let frontInput = frontCameraInput, captureSession.canAddInput(frontInput) {
                captureSession.addInput(frontInput)
            } else { throw CameraControllerError.inputsAreInvalid }
            self.currentCameraPosition = .front
        } else { throw CameraControllerError.noCamerasAvailable }
    }

    func configurePhotoOutput() throws {
        guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
        let photoOutput = AVCapturePhotoOutput()
        self.photoOutput = photoOutput
        photoOutput.setPreparedPhotoSettingsArray(
            [AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecJPEG])],
            completionHandler: nil)
        if captureSession.canAddOutput(photoOutput) { captureSession.addOutput(photoOutput) }
        captureSession.startRunning()
    }

    func prepare(completionHandler: @escaping (Error?) -> Void) {
        DispatchQueue(label: "prepare").async {
                do {
                    self.createCaptureSession()
                    try self.configureCaptureDevices()
                    try self.configureDeviceInputs()
                    try self.configurePhotoOutput()
                } catch {
                    DispatchQueue.main.async {
                        completionHandler(error)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
        }
    }

    func displayPreview(on view: UIView) throws {
        guard let captureSession = self.captureSession, captureSession.isRunning else {
            throw CameraControllerError.captureSessionIsMissing
        }
        let layer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = layer
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.connection?.videoOrientation = .portrait
        view.layer.insertSublayer(layer, at: 0)
        layer.frame = view.frame
    }

    func switchCameras() throws {
        guard let currentCameraPosition = currentCameraPosition,
              let captureSession = self.captureSession, captureSession.isRunning else {
                throw CameraControllerError.captureSessionIsMissing
        }

        captureSession.beginConfiguration()

        func switchToFrontCamera() throws {
            guard let rearCameraInput = self.rearCameraInput, captureSession.inputs.contains(rearCameraInput),
                let frontCamera = self.frontCamera else { throw CameraControllerError.invalidOperation }

            self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)

            captureSession.removeInput(rearCameraInput)

            if let frontInput = frontCameraInput, captureSession.canAddInput(frontInput) {
                captureSession.addInput(frontInput)
                self.currentCameraPosition = .front
            } else {
                throw CameraControllerError.invalidOperation
            }
        }
        func switchToRearCamera() throws {
            guard let frontCameraInput = self.frontCameraInput, captureSession.inputs.contains(frontCameraInput),
                let rearCamera = self.rearCamera else { throw CameraControllerError.invalidOperation }

            self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)

            captureSession.removeInput(frontCameraInput)

            if let rearInput = rearCameraInput, captureSession.canAddInput(rearInput) {
                captureSession.addInput(rearInput)
                self.currentCameraPosition = .rear
            } else {
                throw CameraControllerError.invalidOperation
            }
        }

        switch currentCameraPosition {
        case .front:
            try switchToRearCamera()
        case .rear:
            try switchToFrontCamera()
        }

        captureSession.commitConfiguration()
    }

    func captureImage(completion: @escaping (UIImage?, Error?) -> Void) {
        guard let captureSession = captureSession, captureSession.isRunning else {
            completion(nil, CameraControllerError.captureSessionIsMissing)
            return
        }

        let settings = AVCapturePhotoSettings()
        settings.flashMode = self.flashMode
        self.photoOutput?.capturePhoto(with: settings, delegate: self)
        self.photoCaptureCompletionBlock = completion
    }

    func toZoom(_ sender: UIPinchGestureRecognizer) {
        if self.currentCameraPosition == .rear {
            guard let device = self.rearCamera else {
                return
            }
            if sender.state == .changed {
                let maxZoomFactor = device.activeFormat.videoMaxZoomFactor
                let pinchVelocityDividerFactor: CGFloat = 5.0
                do {
                    try device.lockForConfiguration()
                    defer { device.unlockForConfiguration() }
                    let desiredZoomFactor = device.videoZoomFactor + atan2(sender.velocity, pinchVelocityDividerFactor)
                    device.videoZoomFactor = max(1.0, min(desiredZoomFactor, maxZoomFactor))
                } catch {
                    print(error)
                }
            }

        } else {
            guard let device = self.frontCamera else {
                return
            }
            if sender.state == .changed {
                let maxZoomFactor = device.activeFormat.videoMaxZoomFactor
                let pinchVelocityDividerFactor: CGFloat = 5.0
                do {
                    try device.lockForConfiguration()
                    defer { device.unlockForConfiguration() }
                    let desiredZoomFactor = device.videoZoomFactor + atan2(sender.velocity, pinchVelocityDividerFactor)
                    device.videoZoomFactor = max(1.0, min(desiredZoomFactor, maxZoomFactor))
                } catch {
                    print(error)
                }
            }

        }
    }
}

extension CameraController {
    enum CameraControllerError: Swift.Error {
        case captureSessionAlreadyRunning
        case captureSessionIsMissing
        case inputsAreInvalid
        case invalidOperation
        case noCamerasAvailable
        case unknown
    }
    public enum CameraPosition {
        case front
        case rear
    }
}

extension CameraController: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                            didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                            previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                            resolvedSettings: AVCaptureResolvedPhotoSettings,
                            bracketSettings: AVCaptureBracketedStillImageSettings?,
                            error: Swift.Error?) {
        if let error = error {
            self.photoCaptureCompletionBlock?(nil, error)
        } else if let buffer = photoSampleBuffer,
                  let data = AVCapturePhotoOutput.jpegPhotoDataRepresentation(
                    forJPEGSampleBuffer: buffer,
                    previewPhotoSampleBuffer: nil),
                  let image = UIImage(data: data) {
            self.photoCaptureCompletionBlock?(image, nil)
        } else {
            self.photoCaptureCompletionBlock?(nil, CameraControllerError.unknown)
        }
    }
}
