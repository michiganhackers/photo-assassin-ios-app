//
//  ViewController.swift
//  PhotoAssassin
//
//  Created by Phoebe Liang on 3/14/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//
import Foundation
import Photos
import UIKit

// MARK: - Global Variables
var takenPhoto: UIImage = UIImage()

class ViewController: RoutedViewController {
    // MARK: - UI Elements
    var captureButton: UIButton = UIButton()
    var toggleFlashButton: UIButton = UIButton()
    var toggleCameraButton: UIButton = UIButton()
    var capturePreviewView: UIView = UIView()
    let cameraController = CameraController()

    // MARK: - Overrides
    override var prefersStatusBarHidden: Bool { return true }
}

extension ViewController {
    // MARK: - Custom Functions
    func configureGestureRecognizer() {
        view.isUserInteractionEnabled = true
        view.backgroundColor = .black // Since views must be opaque to detect swipes
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeLeft))
        recognizer.direction = .left
        recognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(recognizer)

        let zoom = UIPinchGestureRecognizer(target: self, action: #selector(onZoom))
        view.addGestureRecognizer(zoom)
    }

    func configureCameraController() {
        cameraController.prepare { error in
            if let error = error {
                print(error)
            }
            self.capturePreviewView.frame = CGRect(x: 0, y: 0,
                                                   width: UIScreen.main.bounds.width,
                                                   height: UIScreen.main.bounds.height)
            try? self.cameraController.displayPreview(on: self.capturePreviewView)
            self.view.addSubview(self.capturePreviewView)
        }
    }
    func styleCaptureButton() {
        captureButton.layer.cornerRadius = 20

        captureButton.frame = CGRect(x: (UIScreen.main.bounds.width / 2) - (35),
                                     y: UIScreen.main.bounds.height - 120,
                                     width: 70, height: 70)
        captureButton.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        captureButton.layer.backgroundColor = UIColor(white: 1.0, alpha: 0.5).cgColor
        captureButton.layer.borderColor = UIColor(white: 1.0, alpha: 1).cgColor
        captureButton.layer.borderWidth = 5
        captureButton.layer.cornerRadius = min(captureButton.frame.width, captureButton.frame.height) / 2
        capturePreviewView.addSubview(captureButton)
    }

    func styleFlashButton() {
        toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash Off Icon"), for: .normal)
        toggleFlashButton.frame = CGRect(x: view.bounds.width - 60, y: 10, width: 50, height: 50)
        toggleFlashButton.addTarget(self, action: #selector(toggleFlash), for: .touchUpInside)
        capturePreviewView.addSubview(toggleFlashButton)
    }

    func styleCameraButton() {
        toggleCameraButton.setImage(#imageLiteral(resourceName: "Front Camera Icon"), for: .normal)
        toggleCameraButton.frame = CGRect(x: view.bounds.width - 60, y: 70, width: 50, height: 50)
        toggleCameraButton.addTarget(self, action: #selector(switchCamera), for: .touchUpInside)
        capturePreviewView.addSubview(toggleCameraButton)
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGestureRecognizer()
        configureCameraController()
        styleCaptureButton()
        styleFlashButton()
        styleCameraButton()
    }

    // MARK: - Event Listeners
    @objc
    func onSwipeLeft(_ recognizer: UIGestureRecognizer) {
        if recognizer.state == .ended {
            routeTo(screen: .menu, animatedWithOptions: [.transitionFlipFromRight])
        }
    }

    @objc
    func clicked(sender: UIButton) {
        cameraController.captureImage { image, error in
            guard let image = image else {
                print(error ?? "Image capture error")
                return
            }
            if let cgImage = image.cgImage, self.cameraController.isFront() {
                takenPhoto = UIImage(cgImage: cgImage, scale: image.scale, orientation: .leftMirrored)
            } else {
                takenPhoto = image
            }
            let vcToPresent = PhotoTakenViewController()
            self.present(vcToPresent, animated: true, completion: nil)
        }
    }

    func setFlash(isEnabled: Bool) {
        if isEnabled {
            cameraController.flashMode = .on
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash On Icon"), for: .normal)
        } else {
            cameraController.flashMode = .off
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash Off Icon"), for: .normal)
        }
    }

    @objc
    func toggleFlash(sender: UIButton) {
        if !cameraController.isFront() {
            if cameraController.flashMode == .on {
                setFlash(isEnabled: false)
            } else {
                setFlash(isEnabled: true)
            }
        }
    }

    @objc
    func switchCamera(sender: UIButton) {
        do {
            try cameraController.switchCameras()
        } catch {
            print(error)
        }

        switch cameraController.currentCameraPosition {
        case .some(.front):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Front Camera Icon"), for: .normal)
            if cameraController.flashMode == .on {
                setFlash(isEnabled: false)
            }
            toggleFlashButton.isEnabled = false
            toggleFlashButton.tintColor = .gray
        case .some(.rear):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Rear Camera Icon"), for: .normal)
            toggleFlashButton.isEnabled = true
            toggleFlashButton.tintColor = .systemBlue

        case .none:
            return
        }
    }

    @objc
    func onZoom(_ sender: UIPinchGestureRecognizer) {
        cameraController.toZoom(sender)
    }
}
