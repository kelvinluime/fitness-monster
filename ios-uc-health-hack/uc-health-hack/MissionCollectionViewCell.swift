//
//  MissionCollectionCell.swift
//  uc-health-hack
//
//  Created by Kelvin Lui on 10/6/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class MissionCollectionViewCell: UICollectionViewCell {
    var mission: Mission? {
        didSet {
            guard let mission = mission else { return }

            missionImageView.image = mission.image
            titleLabel.attributedText = NSAttributedString(string: mission.title, attributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),
                NSAttributedString.Key.foregroundColor : UIColor.white
                ])
            titleLabel.textAlignment = .center
        }
    }

    let missionImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    let indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear
        layer.cornerRadius = 18
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1).cgColor

        setupLayout()
    }

    func setupLayout() {
        addSubview(missionImageView)
        missionImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        missionImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        missionImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        missionImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true

        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: missionImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: frame.width - 16).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
