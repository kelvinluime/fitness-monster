//
//  LoginSceneViewController.swift
//  uc-health-hack
//
//  Created by Kelvin Lui on 10/6/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import GoogleSignIn

class LoginSceneViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(
                withIDToken: authentication.idToken,
                accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
            if error == nil {
                print("Signed In")
                self.initFirestore()
                self.initUser()
                self.switchView()
            } else {
                print("Error with Firebase signIn")
            }
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
    }


    let loginBypass: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(switchView), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(imageLiteralResourceName: "padlock"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let logoView: UIImageView = {
        let imView = UIImageView()
        imView.image = UIImage(imageLiteralResourceName: "monster")
        imView.translatesAutoresizingMaskIntoConstraints = false
        return imView
    }()

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

    @objc func switchView() {
        let mainView = GameSceneViewController()
        self.present(mainView, animated: true, completion: nil)
    }

    func initFirestore() {
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }

    func initUser() {
        let user = Auth.auth().currentUser
        if let user = user {
            let ref = Firestore.firestore().collection("Player").document(user.uid)
            ref.getDocument { (document, error) in
                if let document = document, document.exists {
                    return
                } else {
                    ref.setData([
                        "title": "Fitness Rookie"
                    ])
                }
            }
        }
    }

    override func viewDidLoad() {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
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

        viewContainer.addSubview(logoView)
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height*0.10 * -1).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 120).isActive = true

        viewContainer.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width*0.08 * -1).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height*0.30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 60).isActive = true

        viewContainer.addSubview(logoButton)
        logoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width*0.08).isActive = true
        logoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height*0.30).isActive = true
        logoButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        logoButton.widthAnchor.constraint(equalToConstant: 60).isActive = true

        viewContainer.addSubview(loginBypass)
        loginBypass.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginBypass.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height*0.40 * -1).isActive = true
        loginBypass.heightAnchor.constraint(equalToConstant: 60).isActive = true
        loginBypass.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
