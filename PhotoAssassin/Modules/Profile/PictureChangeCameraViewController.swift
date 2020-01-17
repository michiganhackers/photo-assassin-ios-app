//
//  ChangePictureCameraViewController.swift
//  PhotoAssassin
//
//  Created by Cole Riggle on 1/16/20.
//  Copyright © 2020 Michigan Hackers. All rights reserved.
//

import UIKit

class PictureChangeCameraViewController: BaseCameraViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.gestureRecognizers?.removeAll()
    }
}
