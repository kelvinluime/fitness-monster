//
//  HKValidator.swift
//  uc-health-hack
//
//  Created by Kelvin Lui on 10/6/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit
import HealthKit

class MissionQuries {
    var healthStore: HKHealthStore!
    
    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    func queryData(mission: Mission, completion: @escaping (Double) -> ()) {
        var sampleType: HKSampleType!
        switch mission.title {
        case "protein kick":
            sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein)!
        case "quick attack":
            sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
        case "fiber tornado":
            sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFiber)
        case "mach booster":
            sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed)
        case "water cannon":
            sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)
        default:
            DispatchQueue.main.async { completion(0.0) }
            return
        }

        let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            var data = 0.0
            guard let result = results?.first as? HKQuantitySample else {
                DispatchQueue.main.async { completion(data) }
                return
            }

            DispatchQueue.main.async {
                switch mission.title {
                case "proten kick":
                    data = result.quantity.doubleValue(for: HKUnit.gram())
                case "quick attack":
                    data = result.quantity.doubleValue(for: HKUnit.mile())
                case "fiber tornado":
                    data = result.quantity.doubleValue(for: HKUnit.gram())
                case "mach booster":
                    data = result.quantity.doubleValue(for: HKUnit.count())
                case "water cannon":
                    data = result.quantity.doubleValue(for: HKUnit.literUnit(with: HKMetricPrefix.milli))
                default:
                    break
                }
            }

            DispatchQueue.main.async { completion(data) }
        }

        healthStore.execute(query)
    }
}
