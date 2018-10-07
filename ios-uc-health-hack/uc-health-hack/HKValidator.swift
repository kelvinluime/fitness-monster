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

    func getQuickAttackData() {
        guard let healthStore = self.healthStore else { return }

        
    }

    func validate(mission: Mission) {
        guard let healthStore = self.healthStore else { return }

        switch mission.title {
        case "protein kick":
            let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein)!
            let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
                if let result = results?.first as? HKQuantitySample {
                    print("protein: \(result)")
                } else if let error = error {
                    print("protein error: \(error.localizedDescription)")
                }
            }
            healthStore.execute(query)
            break
        case "quick attack":
            let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
            let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
                if let result = results?.first as? HKQuantitySample {
                    print("distance: \(result)")
                } else if let error = error {
                    print("protein error: \(error.localizedDescription)")
                }
            }
            healthStore.execute(query)
        default:
            return
        }
    }
}
