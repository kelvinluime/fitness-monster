//
//  MissionCollectionCell.swift
//  uc-health-hack
//
//  Created by Kelvin Lui on 10/6/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class MissionCollectionViewCell: UICollectionViewCell {
    let missionImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(imageLiteralResourceName: "fruits")
        return iv
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "fruits", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            ])
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

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

        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: missionImageView.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: frame.width - 16).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
