//
//  Location.swift
//  ResturentViewApp
//
//  Created by Rohit Prajapati on 12/01/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import UIKit


@IBDesignable class LocationView : BaseView {
    
    @IBOutlet weak var allowButton : UIButton!
    @IBOutlet weak var denyButton : UIButton!
    var didTapAllow: (() -> Void)?
    
    @IBAction func allowAction(_ sender: UIButton) {
        didTapAllow?()
    }
    
    @IBAction func denyAction(_ sender: UIButton) {
        
    }
    
}
