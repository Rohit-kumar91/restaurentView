//
//  RestaurentTableViewCell.swift
//  ResturentViewApp
//
//  Created by Rohit Prajapati on 12/01/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var markerImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel : RestaurentListViewModel) {
        restaurantImageView.af_setImage(withURL: viewModel.imageUrl)
        restaurantNameLabel.text = viewModel.name
        locationLabel.text = viewModel.formattedDistance
    }

}
