//
//  GameSceneViewController.swift
//  uc-health-hack
//
//  Created by Kelvin Lui on 10/6/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class GameSceneViewController: UIViewController {
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

        topViewContainer.addSubview(monsterImageView)
        monsterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        monsterImageView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.25).isActive = true 
        monsterImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        monsterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        view.addSubview(monsterImageView)
    }
}
