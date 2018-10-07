//
//  MissionDetailViewController.swift
//  uc-health-hack
//
//  Created by Kelvin Lui on 10/6/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class MissionDetailViewController: UIViewController {
    var mission: Mission? {
        didSet {
            guard let mission = mission else { return }

            titleLabel.attributedText = NSAttributedString(string: mission.title, attributes: [
                NSAttributedString.Key.foregroundColor : UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1),
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32)
                ])
            titleLabel.textAlignment = .center

            damageLabel.attributedText = NSAttributedString(string: "\(mission.damage!) damage points", attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                NSAttributedString.Key.foregroundColor : UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
                ])

            timeLeftLabel.attributedText = NSAttributedString(string: "2 days left", attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                NSAttributedString.Key.foregroundColor : UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
                ])

            targetLabel.attributedText = NSAttributedString(string: "0/40", attributes: [
                NSAttributedString.Key.foregroundColor : UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1),
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)
                ])

            descriptionLabel.attributedText = NSAttributedString(string: mission.description, attributes: [
                NSAttributedString.Key.foregroundColor : UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1),
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22)
                ])

            missionImageView.image = mission.image
        }
    }

    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "close"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(handleClose), for: UIControl.Event.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let missionImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let damageImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(imageLiteralResourceName: "damage")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let damageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let timeLeftImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(imageLiteralResourceName: "stopwatch")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let timeLeftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    let targetImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(imageLiteralResourceName: "target")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let targetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    @objc func handleClose() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupLayout()
    }

    func setupLayout() {
        view.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true

        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: view.frame.width-32).isActive =  true
        titleLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true

        view.addSubview(missionImageView)
        missionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        missionImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        missionImageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        missionImageView.widthAnchor.constraint(equalToConstant: 125).isActive = true

        view.addSubview(damageImageView)
        damageImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        damageImageView.topAnchor.constraint(equalTo: missionImageView.bottomAnchor, constant: 16).isActive = true
        damageImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        damageImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true

        view.addSubview(damageLabel)
        damageLabel.leadingAnchor.constraint(equalTo: damageImageView.trailingAnchor, constant: 8).isActive = true
        damageLabel.centerYAnchor.constraint(equalTo: damageImageView.centerYAnchor).isActive = true
        damageLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        damageLabel.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true

        view.addSubview(timeLeftImageView)
        timeLeftImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        timeLeftImageView.topAnchor.constraint(equalTo: damageImageView.bottomAnchor, constant: 16).isActive = true
        timeLeftImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        timeLeftImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true

        view.addSubview(timeLeftLabel)
        timeLeftLabel.leadingAnchor.constraint(equalTo: timeLeftImageView.trailingAnchor, constant: 8).isActive = true
        timeLeftLabel.centerYAnchor.constraint(equalTo: timeLeftImageView.centerYAnchor).isActive = true
        timeLeftLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        timeLeftLabel.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true

        view.addSubview(targetImageView)
        targetImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        targetImageView.topAnchor.constraint(equalTo: timeLeftLabel.bottomAnchor, constant: 16).isActive = true
        targetImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        targetImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true

        view.addSubview(targetLabel)
        targetLabel.leadingAnchor.constraint(equalTo: targetImageView.trailingAnchor, constant: 8).isActive = true
        targetLabel.centerYAnchor.constraint(equalTo: targetImageView.centerYAnchor).isActive = true
        targetLabel.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        targetLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true

        view.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: targetLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
    }
}
