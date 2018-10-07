//
//  ProfileSceneViewController.swift
//  uc-health-hack
//
//  Created by Rix on 10/7/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class ProfileSceneViewController: UIViewController {

    let backgroundView: UIImageView = {
        let imView = UIImageView()
        imView.image = UIImage(imageLiteralResourceName: "profile-wood2")
        imView.translatesAutoresizingMaskIntoConstraints = false
        return imView
    }()

    let closeView: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleClose), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(imageLiteralResourceName: "close"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let picView: UIImageView = {
        let imView = UIImageView()
        imView.image = UIImage(imageLiteralResourceName: "chara-protagonist")
        imView.translatesAutoresizingMaskIntoConstraints = false
        return imView
    }()

    let emailField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.isUserInteractionEnabled = false
        tf.layer.cornerRadius = 12
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let titleField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.isUserInteractionEnabled = false
        tf.layer.cornerRadius = 12
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let helpButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleHelp), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(imageLiteralResourceName: "close"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func handleClose() {
        let mainView = GameSceneViewController()
        self.present(mainView, animated: true, completion: nil)
    }

    @objc func handleHelp() {
        // TODO
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        setupLayout()
    }

    func setupLayout() {
        let viewContainer = UIView()
        viewContainer.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(viewContainer)
        viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        viewContainer.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        viewContainer.addSubview(backgroundView)
        backgroundView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: viewContainer.topAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: viewContainer.heightAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: viewContainer.widthAnchor).isActive = true

        viewContainer.addSubview(emailField)
        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height * 0.0).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        emailField.widthAnchor.constraint(equalToConstant: 150).isActive = true

        viewContainer.addSubview(titleField)
        titleField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        titleField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12).isActive = true
        titleField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        titleField.widthAnchor.constraint(equalToConstant: 150).isActive = true

        viewContainer.addSubview(picView)
        picView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        picView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height * 0.2 * -1).isActive = true
        picView.heightAnchor.constraint(equalToConstant: view.frame.width * 0.4).isActive = true
        picView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.4).isActive = true

        viewContainer.addSubview(closeView)
        closeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        closeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        closeView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeView.widthAnchor.constraint(equalToConstant: 40).isActive = true

        viewContainer.addSubview(helpButton)
        helpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        helpButton.bottomAnchor.constraint(equalTo: viewContainer.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        helpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        helpButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
