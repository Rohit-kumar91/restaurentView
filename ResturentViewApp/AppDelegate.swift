//
//  AppDelegate.swift
//  ResturentViewApp
//
//  Created by Rohit Prajapati on 12/01/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import UIKit
import Moya
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationServices = LocationServices()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let service = MoyaProvider<YelpService.BusinessProvider>()
    let jsonDecoder = JSONDecoder()
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
       
        locationServices.didChangeStatus = { [weak self] success in
            if success {
                print("IN CHANGE STATUS.")
                self?.locationServices.getLocation()
            }
        }
        
        
        locationServices.newLocation = { [weak self] result in
            switch result {
            case .success(let location):
                print("GETTING NEW LOCATION.")
                print(location)
                self?.loadBusinesses(with: location.coordinate)
            case .failure(let error):
                assertionFailure("Error in gtting the location\(error)")
            }
        }
        
        
        switch locationServices.status {
            
        case .notDetermined, .denied, .restricted:

            self.window = UIWindow(frame: UIScreen.main.bounds)
            let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
            locationViewController.delegate = self
            self.window?.rootViewController = locationViewController
            
        default:
            
            let nav = storyboard.instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.navigationController = nav
            window?.rootViewController = nav
            locationServices.getLocation()
            
            (nav?.topViewController as? RestaurantTableViewController)?.delegate = self
            
            
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    private func loadBusinesses(with coordinate: CLLocationCoordinate2D) {
        service.request(.search(lat: coordinate.latitude, long: coordinate.longitude)) { [weak self] (result) in
            switch result {
            case .success(let response):
                print("response")
                
                guard let strongSelf = self else {
                    return
                }
                
                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
                let viewModels = root?.businesses
                    .compactMap(RestaurentListViewModel.init)
                    .sorted(by: {$0.distance < $1.distance})
                
                if let nav = strongSelf.window?.rootViewController as? UINavigationController,
                    let restaurentListViewController = nav.topViewController as? RestaurantTableViewController {
                    restaurentListViewController.viewModels = viewModels ?? []
                }
                
                
            case .failure(let error):
                print("Error\(error)")
            }
        }
    }
    
    
    private func loadDetails(withId id: String) {

        service.request(.details(id: id)) { [weak self] (result) in
            
            switch result {
            case .success(let response):
                
                guard let strongSelf = self else {
                    return
                }
                
                if let details = try? strongSelf.jsonDecoder.decode(Details.self, from: response.data) {
                    let detailsViewModel = DetailsViewModel(details: details)
                    (strongSelf.navigationController?.topViewController as? DetailsFoodViewController)?.viewModel = detailsViewModel
                }
                
                
            case .failure(let error):
                print("Failure \(error)")
                
            }
        }
    }
    
}

extension AppDelegate: LocationActions, ListActions {
    func didTapAllow() {
        locationServices.requestLocationAuthorization()
    }
    
    func didTapCell(_ viewModels: RestaurentListViewModel) {
        loadDetails(withId: viewModels.id)
    }
}

