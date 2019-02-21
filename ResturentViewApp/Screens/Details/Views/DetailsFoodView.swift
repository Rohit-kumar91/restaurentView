
//
//  DetailsFoodView.swift
//  ResturentViewApp
//
//  Created by Rohit Prajapati on 12/01/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import UIKit
import MapKit

@IBDesignable class DetailsFoodView : BaseView {
    
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var pageControl : UIPageControl?
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var hoursLabel: UILabel?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var ratingLabel: UILabel?
    @IBOutlet weak var mapView: MKMapView?
    
    
    @IBAction func handleControl(_ sender: UIPageControl) {
        
    }
    
}
