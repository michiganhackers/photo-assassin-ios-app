//
//  PhotoTakenViewController.swift
//  PhotoAssassin
//
//  Created by Calvin Zheng on 3/28/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class PhotoTakenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let clearPhotoButton = UIButton()
        let sendPhotoButton = UIButton()
        let clearPhotoImage = UIImage(named: "baseline_clear_black_18dp.png")
        let sendPhotoImage = UIImage(named: "baseline_send_black_18dp.png")
        sendPhotoButton.frame = CGRect(x: self.view.bounds.width - 40, y: sendPhotoButton.frame.origin.y, width: 30, height: 30)
        clearPhotoButton.frame = CGRect(x: clearPhotoButton.frame.origin.x,
                                        y: clearPhotoButton.frame.origin.y, width: 30, height: 30)

        clearPhotoButton.setBackgroundImage(clearPhotoImage, for: .normal)
        sendPhotoButton.setBackgroundImage(sendPhotoImage, for: .normal)
        self.view.addSubview(clearPhotoButton)
        self.view.addSubview(sendPhotoButton)
        
        clearPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        sendPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        if #available(iOS 11.0, *) {
            clearPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            clearPhotoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
            sendPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            sendPhotoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true;
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
        // Do any additional setup after loading the view.
    }
}
