//
//  Mission.swift
//  uc-health-hack
//
//  Created by Kelvin Lui on 10/6/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class Mission {
    var title: String!
    var description: String!
    var damage: Int!
    var image: UIImage!

    init(title: String, description: String, damage: Int, image: UIImage) {
        self.title = title
        self.description = description
        self.damage = damage
        self.image = image
    }
}
