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

    func validate(mission: Mission, completion: @escaping (HKQuantitySample) -> ()) {
        guard let healthStore = self.healthStore else { return }

        var sampleType: HKSampleType?
        switch mission.title {
        case "protein kick":
            sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein)!
        case "quick attack":
            sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
        case "fiber tornado":
            sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFiber)!
        case "mach booster":
            sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed)!
        case "flameburst":
            sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFatSaturated)!
        case "water cannon":
            sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)
        default:
            return
        }

        let query = HKSampleQuery(sampleType: sampleType!, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.first as? HKQuantitySample {
                completion(result)
            } else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }

        healthStore.execute(query)
    }
}
