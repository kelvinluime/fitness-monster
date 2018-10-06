//
//  GameSceneViewController.swift
//  uc-health-hack
//
//  Created by Kelvin Lui on 10/6/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class GameSceneViewController: UIViewController {
    let profileButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleProfile), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(imageLiteralResourceName: "profile"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let promptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "you can do it!", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : UIColor.white
            ])
        return label
    }()

    let monsterImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(imageLiteralResourceName: "monster")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let textField: UITextView = {
        let tf = UITextView()
        return tf
    }()

    @objc func handleProfile() {

    }

    override func viewDidLoad() {
        view.backgroundColor = .white

        setupLayout()
    }

    func setupLayout() {
        let topViewContainer = UIView()
        topViewContainer.translatesAutoresizingMaskIntoConstraints = false
        topViewContainer.backgroundColor = UIColor(red: 184/255, green: 217/255, blue: 113/255, alpha: 1)

        view.addSubview(topViewContainer)
        topViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topViewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topViewContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topViewContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true

        topViewContainer.addSubview(profileButton)
        profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: 24).isActive = true

        topViewContainer.addSubview(monsterImageView)
        monsterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        monsterImageView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.25).isActive = true 
        monsterImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        monsterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

            

    }
}
