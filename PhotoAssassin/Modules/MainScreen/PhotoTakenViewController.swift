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
        self.view.backgroundColor = UIColor.white;
        let clearPhotoButton = UIButton()
        let sendPhotoButton = UIButton()
        let clearPhotoImage = UIImage(named: "baseline_clear_black_18dp.png")
        let sendPhotoImage = UIImage(named: "baseline_send_black_18dp.png")
        clearPhotoButton.frame = CGRect(x: 0, y: 20, width: 30, height: 30)
        sendPhotoButton.frame = CGRect(x: self.view.bounds.width-40, y: 20, width: 30, height: 30)
        clearPhotoButton.setBackgroundImage(clearPhotoImage, for: .normal)
        sendPhotoButton.setBackgroundImage(sendPhotoImage, for: .normal)
        self.view.addSubview(clearPhotoButton)
        self.view.addSubview(sendPhotoButton)
        print("hello")
        // Do any additional setup after loading the view.
    }
}
