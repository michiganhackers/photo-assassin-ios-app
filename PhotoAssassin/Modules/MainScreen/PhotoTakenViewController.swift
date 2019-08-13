//
//  PhotoTakenViewController.swift
//  PhotoAssassin
//
//  Created by Calvin Zheng on 3/28/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//
import UIKit

class PhotoTakenViewController: UIViewController {
    // MARK: - Overrides
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        let imageView = UIImageView(image: takenPhoto)
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(imageView)
        let clearPhotoTinted = R.image.baseline_clear_black_18dp()?.withRenderingMode(.alwaysTemplate)
        let clearPhotoButton = UIButton()
        clearPhotoButton.setBackgroundImage(clearPhotoTinted, for: .normal)
        clearPhotoButton.tintColor = .white
        clearPhotoButton.layer.shadowColor = UIColor.black.cgColor
        clearPhotoButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        clearPhotoButton.layer.shadowOpacity = 1.0
        clearPhotoButton.layer.shadowRadius = 10.0
        clearPhotoButton.layer.masksToBounds = false
        let sendPhotoTinted = R.image.baseline_send_black_18dp()?.withRenderingMode(.alwaysTemplate)
        let sendPhotoButton = UIButton()
        sendPhotoButton.setBackgroundImage(sendPhotoTinted, for: .normal)
        sendPhotoButton.tintColor = .white
        sendPhotoButton.layer.shadowColor = UIColor.black.cgColor
        sendPhotoButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        sendPhotoButton.layer.shadowOpacity = 1.0
        sendPhotoButton.layer.shadowRadius = 10.0
        sendPhotoButton.layer.masksToBounds = false
        clearPhotoButton.addTarget(self, action: #selector(clearPhoto), for: .touchUpInside)
        sendPhotoButton.addTarget(self, action: #selector(chooseLobby), for: .touchUpInside)
        sendPhotoButton.frame = CGRect(x: self.view.bounds.width - 40, y: sendPhotoButton.frame.origin.y, width: 50, height: 50)
        clearPhotoButton.frame = CGRect(x: clearPhotoButton.frame.origin.x,
                                        y: clearPhotoButton.frame.origin.y, width: 50, height: 50)
        self.view.addSubview(clearPhotoButton)
        self.view.addSubview(sendPhotoButton)
        
        clearPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        sendPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            clearPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
            clearPhotoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
            sendPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
            sendPhotoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true;
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true;
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true;
        } else {
            // Fallback on earlier versions
        }
        let clearPhotoWidthConstraint = NSLayoutConstraint (item: clearPhotoButton,
                                                            attribute: NSLayoutConstraint.Attribute.width,
                                                            relatedBy: NSLayoutConstraint.Relation.equal,
                                                            toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                            multiplier: 1, constant: 30)
        let clearPhotoHeightConstraint = NSLayoutConstraint (item: clearPhotoButton,
                                                             attribute: NSLayoutConstraint.Attribute.height,
                                                             relatedBy: NSLayoutConstraint.Relation.equal,
                                                             toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                             multiplier: 1, constant: 30)
        let sendPhotoWidthConstraint = NSLayoutConstraint (item: sendPhotoButton,
                                                           attribute: NSLayoutConstraint.Attribute.width,
                                                           relatedBy: NSLayoutConstraint.Relation.equal,
                                                           toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                           multiplier: 1, constant: 30)
        let sendPhotoHeightConstraint = NSLayoutConstraint (item: sendPhotoButton,
                                                            attribute: NSLayoutConstraint.Attribute.height,
                                                            relatedBy: NSLayoutConstraint.Relation.equal,
                                                            toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                            multiplier: 1, constant: 30)
        clearPhotoButton.addConstraint(clearPhotoWidthConstraint)
        clearPhotoButton.addConstraint(clearPhotoHeightConstraint)
        sendPhotoButton.addConstraint(sendPhotoHeightConstraint)
        sendPhotoButton.addConstraint(sendPhotoWidthConstraint)
        
    }
    
    // MARK: - Custom Functions
    func push(navigationScreen: MenuNavigationController.Screen) {
        if let navController = navigationController as? MenuNavigationController {
            navController.push(navigationScreen)
        }
    }
    
    // MARK: - Event Listeners
    @objc func clearPhoto(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func chooseLobby(sender: UIButton) {
        //Unimplemented Function
        print("Choose Lobby")
        push(navigationScreen: .activeGames)
    }
}
