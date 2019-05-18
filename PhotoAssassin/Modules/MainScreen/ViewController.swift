//
//  ViewController.swift
//  PhotoAssassin
//
//  Created by Phoebe Liang on 3/14/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//
import Foundation
import UIKit
import Photos

var takenPhoto: UIImage = UIImage()

class ViewController: UIViewController {
    // @IBOutlet fileprivate var captureButton: UIButton!
    var captureButton : UIButton = UIButton()
    
    // Flash button
    var toggleFlashButton : UIButton = UIButton()
    
    var toggleCameraButton: UIButton = UIButton()
    
    var capturePreviewView: UIView = UIView()
    
    ///Displays a preview of the video output generated by the device's cameras.
    //@IBOutlet fileprivate var capturePreviewView: UIView!
    
    ///Allows the user to put the camera in photo mode.
    //@IBOutlet fileprivate var photoModeButton: UIButton!
    // @IBOutlet fileprivate var toggleCameraButton: UIButton!
    // @IBOutlet fileprivate var toggleFlashButton: UIButton!
    
    ///Allows the user to put the camera in video mode.
    //@IBOutlet fileprivate var videoModeButton: UIButton!
    
    let cameraController = CameraController()
    
    override var prefersStatusBarHidden: Bool { return true }
}

extension ViewController {
    override func viewDidLoad() {
        func configureCameraController() {
            cameraController.prepare {(error) in
                if let error = error {
                    print(error)
                }
                self.capturePreviewView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
                try? self.cameraController.displayPreview(on: self.capturePreviewView)
                self.view.addSubview(self.capturePreviewView)
            }
        }
        func styleCaptureButton() {
            captureButton.layer.cornerRadius = 20
            
            captureButton.frame = CGRect(x: (UIScreen.main.bounds.width / 2) - (35), y: UIScreen.main.bounds.height - 120, width: 70, height: 70)
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
        
        configureCameraController()
        
        styleCaptureButton()
        styleFlashButton()
        styleCameraButton()
    }
    
    @objc func clicked(sender: UIButton) {
        cameraController.captureImage {(image, error) in
            guard let image = image else {
                print(error ?? "Image capture error")
                return
            }
            
            takenPhoto = image;
            let vc = PhotoTakenViewController()
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func toggleFlash(sender: UIButton) {
        if cameraController.flashMode == .on {
            cameraController.flashMode = .off
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash Off Icon"), for: .normal)
        }
            
        else {
            cameraController.flashMode = .on
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash On Icon"), for: .normal)
        }
    }
    
    @objc func switchCamera(sender: UIButton) {
        do {
            try cameraController.switchCameras()
        }
            
        catch {
            print(error)
        }
        
        switch cameraController.currentCameraPosition {
        case .some(.front):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Front Camera Icon"), for: .normal)
            
        case .some(.rear):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Rear Camera Icon"), for: .normal)
            
        case .none:
            return
        }
    }
    
}