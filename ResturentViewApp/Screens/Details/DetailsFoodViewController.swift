//
//  DetailsFoodViewController.swift
//  ResturentViewApp
//
//  Created by Rohit Prajapati on 12/01/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import UIKit

class DetailsFoodViewController: UIViewController {
    
    @IBOutlet weak var detailsFoodView: DetailsFoodView?
    
    var viewModel: DetailsViewModel? {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailsFoodView?.collectionView?.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
        //detailsFoodView?.collectionView?.delegate = self
        detailsFoodView?.collectionView?.dataSource = self
        
    }
    
    
    func updateView() {
        
        if let viewModel = viewModel {
            
            detailsFoodView?.priceLabel?.text = viewModel.price
            detailsFoodView?.hoursLabel?.text = viewModel.isOpen
            detailsFoodView?.locationLabel?.text = viewModel.phoneNumber
            detailsFoodView?.ratingLabel?.text = viewModel.rating
            
        }
        
    }
}

extension DetailsFoodViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.imageUrls.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! DetailsCollectionViewCell
        return cell
    }
    
    

    
}
