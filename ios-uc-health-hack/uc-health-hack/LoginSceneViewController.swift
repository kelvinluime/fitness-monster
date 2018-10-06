//
//  LoginSceneViewController.swift
//  uc-health-hack
//
//  Created by Kelvin Lui on 10/6/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginSceneViewController: UIViewController, GIDSignInUIDelegate {
    let loginButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleLogin), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(imageLiteralResourceName: "padlock"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let logoButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleLogin), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(imageLiteralResourceName: "google-logo"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let textField: UITextView = {
        let tf = UITextView()
        return tf
    }()

    @objc func handleLogin() {
        GIDSignIn.sharedInstance().signIn()
    }

    override func viewDidLoad() {
        GIDSignIn.sharedInstance().uiDelegate = self
        view.backgroundColor = .white
        setupLayout()
    }

    func setupLayout() {
        let topViewContainer = UIView()
        topViewContainer.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(topViewContainer)
        topViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topViewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topViewContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topViewContainer.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        topViewContainer.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width*0.08 * -1).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height*0.30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 60).isActive = true

        topViewContainer.addSubview(logoButton)
        logoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width*0.08).isActive = true
        logoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height*0.30).isActive = true
        logoButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        logoButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
