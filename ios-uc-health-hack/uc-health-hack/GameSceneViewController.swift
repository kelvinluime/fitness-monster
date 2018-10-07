//
//  GameSceneViewController.swift
//  uc-health-hack
//
//  Created by Kelvin Lui on 10/6/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit
import HealthKit
import HealthKitUI

class GameSceneViewController: UIViewController {
    let cellId = "cellId"
    var healthStore: HKHealthStore? {
        didSet {
            guard let healthStore = self.healthStore else { return }
            validator = HKValidator(healthStore: healthStore)
        }
    }
    var missions: [Mission]? = []
    var validator: HKValidator?

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
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25),
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

    let brickImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(imageLiteralResourceName: "brick")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
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
        label.attributedText = NSAttributedString(string: "skills", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : UIColor.white
            ])
        label.textAlignment = .center
        return label
    }()

    @objc func handleProfile() {

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        self.missions = getHardcodedMissions()
        requestHKPermissons()
        setupLayout()
    }

    func getHardcodedMissions() -> [Mission] {
        let quickAttackMission = Mission(title: "quick attack", description: "In order to damage the monster, you need to travel 0.2 miles by foot. Walking can help by improving overall physical health and aid weight loss. Don't cheat!", damage: 2, image: UIImage(imageLiteralResourceName: "quick-attack"))
        let megaPunchMission = Mission(title: "mega punch", description: "In order to damage the monster, you have to consume around 2000 calories for 1 day(s). Balance diet is essential!", damage: 2, image: UIImage(imageLiteralResourceName: "mega-punch"))
        let fiberTornadoMission = Mission(title: "fiber tornado", description: "In order to damage the monster, you have to consume 30 grams of fiber for 1 day(s). Fiber can help by relieving constipation!", damage: 2, image: UIImage(imageLiteralResourceName: "fiber-tornado"))
        let proteinKickMission = Mission(title: "protein kick", description: "In order to damage the monster, you have to consume 40 grams of protein for 1 day(s). Protein is an importing building block of bones, muscles, skin and blood!", damage: 2, image: UIImage(imageLiteralResourceName: "protein-kick"))
        let nightmareAttackMission = Mission(title: "nightmare attack", description: "In order to damage the monster, you need to have 8 hours of sleep for 1 day(s). Not having enough hours sleep can need to diabetes, heart attack, heart failure and stroke!", damage: 2, image: UIImage(imageLiteralResourceName: "nightmare-attack"))
        let machBoosterMission = Mission(title: "mach booster", description: "In order to damage the monster, you should travel up/down in a total of 4 floors by stairs. Climbing stairs are one of the easiest ways to obtain a huge amount of cardio benefits!", damage: 2, image: UIImage(imageLiteralResourceName: "mach-booster"))
        let psybeamMission = Mission(title: "psybeam", description: "In order to damage the monster, you need to meditate for 30 minutes. Mediation benefits by reducing stress and controlling anxiety.", damage: 2, image: UIImage(imageLiteralResourceName: "psybeam"))
        let flameBurstMission = Mission(title: "flameburst", description: "In order to damage the monster, you need to have less than 22 grams saturated fat for 1 day(s). Eating too much saturated fat will increase your risk for heart disease.", damage: 1, image: UIImage(imageLiteralResourceName: "flameburst"))
        let waterCannonMission = Mission(title: "water cannon", description: "In order to damage the monster, you should drink 8 cups of water for 1 day(s). Your body is composed of about 60% water. Drinking 8 cups of Water Helps Maintain the Balance of Body Fluids.", damage: 2, image: UIImage(imageLiteralResourceName: "water-cannon"))
        let steelStrikeMission = Mission(title: "steel strike", description: "Congruation! You have obtained the ultimate weapon: a healthy body. No monster can stop you now.", damage: 10, image: UIImage(imageLiteralResourceName: "steel-strike"))

        return [
            quickAttackMission,
            megaPunchMission,
            fiberTornadoMission,
            proteinKickMission,
            nightmareAttackMission,
            machBoosterMission,
            psybeamMission,
            flameBurstMission,
            waterCannonMission,
            steelStrikeMission
        ]
    }

    func requestHKPermissons() {
        guard HKHealthStore.isHealthDataAvailable() else { return }

        self.healthStore = HKHealthStore()
        let readDataTypes = self.dataTypesToRead()
        self.healthStore?.requestAuthorization(toShare: nil, read: readDataTypes as? Set<HKObjectType>, completion: { (result, error) in
            if let error =  error {
                let alert = UIAlertController(title: "Error", message: "There is an error when trying to request authorization on health data: \(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }

    func dataTypesToRead() -> Set<AnyHashable> {
        let weightType = HKObjectType.quantityType(forIdentifier: .bodyMass)
        let sleepAnalysis = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)
        let step = HKObjectType.quantityType(forIdentifier: .stepCount)
        let walking = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)
        let water = HKObjectType.quantityType(forIdentifier: .dietaryWater)
        let dietaryProtein = HKObjectType.quantityType(forIdentifier: .dietaryProtein)
        let flightsClimbed = HKObjectType.quantityType(forIdentifier: .flightsClimbed)
        let fat = HKObjectType.quantityType(forIdentifier: .dietaryFatSaturated)
        let fiber = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFiber)

        return Set<AnyHashable>([
            weightType,
            step,
            walking,
            sleepAnalysis,
            water,
            dietaryProtein,
            flightsClimbed,
            fat,
            fiber
            ])
    }

    func setupLayout() {
        let topViewContainer = UIImageView()
        topViewContainer.image = UIImage(imageLiteralResourceName: "forest")
        topViewContainer.contentMode = .scaleAspectFill
        topViewContainer.clipsToBounds = true
        topViewContainer.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(topViewContainer)
        topViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topViewContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: -32).isActive = true
        topViewContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topViewContainer.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 32).isActive = true

        view.addSubview(profileButton)
        profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: 24).isActive = true

        view.addSubview(monsterImageView)
        monsterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        monsterImageView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.25).isActive = true
        monsterImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        monsterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        view.addSubview(hpBar)
        hpBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hpBar.bottomAnchor.constraint(equalTo: monsterImageView.topAnchor, constant: -16).isActive = true
        hpBar.heightAnchor.constraint(equalToConstant: 8).isActive = true
        hpBar.widthAnchor.constraint(equalToConstant: 90).isActive = true

        view.addSubview(promptLabel)
        promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        promptLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        promptLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        promptLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        view.addSubview(brickImageView)
        brickImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        brickImageView.topAnchor.constraint(equalTo: topViewContainer.bottomAnchor, constant: -80).isActive = true
        brickImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        brickImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 96).isActive = true

        view.addSubview(missionsTitleLabel)
        missionsTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        missionsTitleLabel.topAnchor.constraint(equalTo: topViewContainer.bottomAnchor, constant: 32).isActive = true
        missionsTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width)
        missionsTitleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let missionsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 120), collectionViewLayout: flowLayout)
        missionsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        missionsCollectionView.backgroundColor = .clear
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
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let missions = self.missions else { return UICollectionViewCell() }
        guard let validator = self.validator else { return UICollectionViewCell() }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MissionCollectionViewCell
        cell.mission = missions[indexPath.row]
        validator.validate(mission: cell.mission!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Use", style: UIAlertAction.Style.default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "View Details", style: UIAlertAction.Style.default, handler: { (action) in
            let vc = MissionDetailViewController()
            vc.mission = self.missions?[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
}

extension GameSceneViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 110)
    }
}
