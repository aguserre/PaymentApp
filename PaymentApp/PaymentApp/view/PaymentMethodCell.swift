//
//  PaymentMethodCell.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 12/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit

class PaymentMethodCell: UITableViewCell {
    @IBOutlet weak var backgroundCircleView: UIView!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var contentBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCircleView.layer.cornerRadius = 20
        contentBackgroundView.layer.cornerRadius = 10
        
        contentBackgroundView.layer.shadowColor = UIColor.black.cgColor
        contentBackgroundView.layer.shadowOffset = CGSize(width: 5, height: 1)
        contentBackgroundView.layer.shadowRadius = 15
        contentBackgroundView.layer.shadowOpacity = 0.7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
