//
//  Missions.swift
//  uc-health-hack
//
//  Created by Kelvin Lui on 10/6/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class Missions {
    lazy var missions: [Mission] = {
        let quickAttackMission = Mission(title: "quick attack", description: "In order to damage the monster, you need to travel 0.2 miles by foot. Walking can help by improving overall physical health and aid weight loss. Don't cheat!", damage: 2, image: UIImage(imageLiteralResourceName: "quick-attack"))
        let megaPunchMission = Mission(title: "mega punch", description: "In order to damage the monster, you have to consume around 2000 calories for 1 day(s). Balance diet is essential!", damage: 2, image: UIImage(imageLiteralResourceName: "mega-punch"))
        let fiberTornadoMission = Mission(title: "fiber tornado", description: "", damage: 2, image: UIImage(imageLiteralResourceName: "fiber-tornado"))
        let proteinKickMission = Mission(title: "protein kick", description: "", damage: 2, image: UIImage(imageLiteralResourceName: "protein-kick"))
        let nightmareAttackMission = Mission(title: "nightmare attack", description: "", damage: 2, image: UIImage(imageLiteralResourceName: "nightmare-attack"))
        let machBoosterMission = Mission(title: "mach booster", description: "", damage: 2, image: UIImage(imageLiteralResourceName: "mach-booster"))
        let psybeamMission = Mission(title: "psybeam", description: "", damage: 2, image: UIImage(imageLiteralResourceName: "psybeam"))
        let flameBurstMission = Mission(title: "flame brust", description: "", damage: 1, image: UIImage(imageLiteralResourceName: "flame-brust"))
        let waterCannonMission = Mission(title: "water cannon", description: "", damage: 2, image: UIImage(imageLiteralResourceName: ""))
        let steelStrikeMission = Mission(title: "steel strike", description: "", damage: 10, image: UIImage(imageLiteralResourceName: "steel-strike"))
        
        return [
            quickAttackMission
        ]
    }()
}
