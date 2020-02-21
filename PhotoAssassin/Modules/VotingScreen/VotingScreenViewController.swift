//
//  VotingScreenViewController.swift
//  PhotoAssassin
//
//  Created by hadileonardd on 10/3/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class VotingScreenViewController: RoutedViewController {
    static let largeTextSize: CGFloat = 64
    static let mediumTextSize: CGFloat = 38
    static let smallTextSize: CGFloat = 30
    let backgroundGradient = BackgroundGradient()
    // MARK: - Overrides
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
        backgroundGradient.layoutInView(view)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundGradient.addToView(view)
        addSubviews()
    }
    func setUpConstraints() {
        let margin = view.layoutMarginsGuide
        voteTitle.translatesAutoresizingMaskIntoConstraints = false
        photoTaken.translatesAutoresizingMaskIntoConstraints = false
        isThisAPicture.translatesAutoresizingMaskIntoConstraints = false
        voteNo.translatesAutoresizingMaskIntoConstraints = false
        voteYes.translatesAutoresizingMaskIntoConstraints = false
        imageViewOne.translatesAutoresizingMaskIntoConstraints = false
        imageViewTwo.translatesAutoresizingMaskIntoConstraints = false
        voteTitle.topAnchor.constraint(equalTo: margin.topAnchor, constant: 5).isActive = true
        voteTitle.centerXAnchor.constraint(equalTo: margin.centerXAnchor).isActive = true
        isThisAPicture.topAnchor.constraint(equalTo: voteTitle.bottomAnchor, constant: 5).isActive = true
        isThisAPicture.centerXAnchor.constraint(equalTo: margin.centerXAnchor).isActive = true

        imageViewOne.topAnchor.constraint(equalTo: isThisAPicture.bottomAnchor, constant: 20).isActive = true
        imageViewOne.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 5).isActive = true
        imageViewOne.rightAnchor.constraint(equalTo: margin.centerXAnchor, constant: -10).isActive = true
        imageViewTwo.topAnchor.constraint(equalTo: isThisAPicture.bottomAnchor, constant: 20).isActive = true
        imageViewTwo.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: 5).isActive = true
        imageViewTwo.leftAnchor.constraint(equalTo: margin.centerXAnchor, constant: 10).isActive = true
        photoTaken.topAnchor.constraint(equalTo: imageViewOne.bottomAnchor, constant: 10).isActive = true
        // photoTaken.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 5).isActive = true
        photoTaken.centerXAnchor.constraint(equalTo: imageViewOne.centerXAnchor).isActive = true
        profilePicture.topAnchor.constraint(equalTo: imageViewTwo.bottomAnchor, constant: 10).isActive = true
        // profilePicture.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -5).isActive = true
        profilePicture.centerXAnchor.constraint(equalTo: imageViewTwo.centerXAnchor).isActive = true
        voteYes.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 20).isActive = true
        voteYes.topAnchor.constraint(equalTo: photoTaken.bottomAnchor, constant: 10).isActive = true
        voteYes.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 10).isActive = true
        voteYes.centerXAnchor.constraint(equalTo: margin.centerXAnchor, constant: 0).isActive = true
//        voteYes.heightAnchor.constraint(equalToConstant: 63).isActive = true
        voteNo.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 20).isActive = true
        voteNo.topAnchor.constraint(equalTo: voteYes.bottomAnchor, constant: 20).isActive = true
        voteNo.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -20).isActive = true
        voteNo.centerXAnchor.constraint(equalTo: margin.centerXAnchor, constant: 0).isActive = true
//        voteNo.heightAnchor.constraint(equalToConstant: 63).isActive = true
    }
    let voteTitle = UILabel( "Vote", attributes:
        [.foregroundColor: Colors.text,
         .font: R.font.economicaBold.orDefault(size: largeTextSize)] )
    let isThisAPicture = UILabel("Is this a picture of Ben?", attributes:
        [.foregroundColor: Colors.text,
         .font: R.font.economicaBold.orDefault(size: mediumTextSize)] )
    let photoTaken = UILabel("Photo Taken", attributes:
        [.foregroundColor: Colors.seeThroughText,
         .font: R.font.economicaBold.orDefault(size: smallTextSize)])
    let profilePicture = UILabel("Profile Picture", attributes:
        [.foregroundColor: Colors.seeThroughText,
        .font: R.font.economicaBold.orDefault(size: smallTextSize)] )
    lazy var voteYes: UIButton = {
        let button = TransparentButton("Vote Yes")
        button.isEnabled = false
        button.addTarget(self, action: #selector (vote_func_yes), for: .touchUpInside)
          button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var voteNo: UIButton = {
           let button = TransparentButton("Vote No")
           button.isEnabled = false
           button.backgroundColor = UIColor(white:1, alpha: 0.2)
        button.titleLabel?.textColor = UIColor.white
           button.addTarget(self, action: #selector (vote_func_no), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()
    var imageViewOne: UIImageView = {
        let view = UIImageView()
        view.layer.borderWidth = 100
        view.layer.borderColor = Colors.text.cgColor
        return view
    }()
    var imageViewTwo: UIImageView = {
        let view = UIImageView()
        view.layer.borderWidth = 100
        view.layer.borderColor = Colors.text.cgColor
        return view
    }()
    func addSubviews() {
        view.addSubview(voteTitle)
        view.addSubview(isThisAPicture)
        view.addSubview(photoTaken)
        view.addSubview(profilePicture)
        view.addSubview(voteYes)
        view.addSubview(voteNo)
        view.addSubview(imageViewOne)
        view.addSubview(imageViewTwo)
    }
    @objc
    func vote_func_yes () {
        print("Vote Yes")
    }
    @objc
    func vote_func_no () {
        print("Vote No")
    }
}
