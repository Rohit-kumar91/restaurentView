//
//  RestaurantTableViewController.swift
//  ResturentViewApp
//
//  Created by Rohit Prajapati on 12/01/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import UIKit

protocol ListActions: class {
    func didTapCell(_ viewModels: RestaurentListViewModel)
}

class RestaurantTableViewController: UITableViewController {

    var viewModels = [RestaurentListViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    weak var delegate : ListActions?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantsCell", for: indexPath) as! RestaurentTableViewCell
        
        let vm = viewModels[indexPath.row]
        
        cell.configure(with: vm)
        

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = viewModels[indexPath.row]
        self.delegate?.didTapCell(vm)
    }
   

   
}
