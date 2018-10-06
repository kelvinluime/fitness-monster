//
//  GameSceneViewController.swift
//  uc-health-hack
//
//  Created by Kelvin Lui on 10/6/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class GameSceneViewController: UIViewController {
    let cellId = "cellId"

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
        label.attributedText = NSAttributedString(string: "\"you can do it!\"", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : UIColor.white
            ])
        label.textAlignment = .center
        return label
    }()

    let monsterImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(imageLiteralResourceName: "monster")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let hpBar: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 230/255, green: 36/255, blue: 36/255, alpha: 1)
        v.layer.cornerRadius = 4
        return v
    }()

    let missionsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "missions", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
            ])
        label.textAlignment = .center
        return label
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

        topViewContainer.addSubview(hpBar)
        hpBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hpBar.bottomAnchor.constraint(equalTo: monsterImageView.topAnchor, constant: -16).isActive = true
        hpBar.heightAnchor.constraint(equalToConstant: 8).isActive = true
        hpBar.widthAnchor.constraint(equalToConstant: 90).isActive = true

        topViewContainer.addSubview(promptLabel)
        promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        promptLabel.topAnchor.constraint(equalTo: monsterImageView.bottomAnchor , constant: 16).isActive = true
        promptLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        promptLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        view.addSubview(missionsTitleLabel)
        missionsTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        missionsTitleLabel.topAnchor.constraint(equalTo: topViewContainer.bottomAnchor, constant: 32).isActive = true
        missionsTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width)
        missionsTitleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let missionsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80), collectionViewLayout: flowLayout)
        missionsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        missionsCollectionView.backgroundColor = .white
        missionsCollectionView.delegate = self
        missionsCollectionView.dataSource = self
        missionsCollectionView.register(MissionCollectionViewCell.self, forCellWithReuseIdentifier: cellId)

        view.addSubview(missionsCollectionView)
        missionsCollectionView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.75).isActive = true
        missionsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        missionsCollectionView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        missionsCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
}

extension GameSceneViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MissionCollectionViewCell
        return cell
    }
}

extension GameSceneViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 80)
    }
}
