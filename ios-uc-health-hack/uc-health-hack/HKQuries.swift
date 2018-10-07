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

    func queryProteinData(completion: @escaping (Double) -> ()) {
        guard let healthStore = self.healthStore else { return }

        let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein)!
        let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            guard let result = results?.first as? HKQuantitySample else {
                completion(0)
                return
            }

            DispatchQueue.main.async {
                completion(result.quantity.doubleValue(for: HKUnit.gram()))
            }
        }

        healthStore.execute(query)
    }

    func queryStepsData(completion: @escaping (Double) -> ()) {
        guard let healthStore = self.healthStore else { return }

        let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein)!
        let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            guard let result = results?.first as? HKQuantitySample else {
                completion(0)
                return
            }

            DispatchQueue.main.async {
                completion(result.quantity.doubleValue(for: HKUnit.gram()))
            }
        }

        healthStore.execute(query)
    }
}
