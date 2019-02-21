//
//  LocationViewController.swift
//  ResturentViewApp
//
//  Created by Rohit Prajapati on 12/01/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import UIKit

protocol LocationActions: class {
    func didTapAllow()
}

class LocationViewController: UIViewController {

    @IBOutlet weak var locationView : LocationView!
    weak var delegate: LocationActions?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationView.didTapAllow = {
            print("Allow location services.")
            self.delegate?.didTapAllow()
        }
        
//        locationServices?.didChangeStatus = { [weak self] success in
//            if success {
//                print("IN CHANGE STATUS.")
//                self?.locationServices?.getLocation()
//            }
//        }
//
//        locationServices?.newLocation = { [weak self] result in
//            switch result {
//            case .success(let location):
//                print("GETTING NEW LOCATION.")
//                print(location)
//            case .failure(let error):
//                assertionFailure("Error in gtting the location\(error)")
//            }
//        }
        
        
    }
}
