//
//  HKValidator.swift
//  uc-health-hack
//
//  Created by Kelvin Lui on 10/6/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit
import HealthKit

class HKValidator {
    var healthStore: HKHealthStore!
    
    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }
}
