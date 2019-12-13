//
//  PaymentMethodsTableViewController.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 12/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit
import Kingfisher

class PaymentMethodsTableViewController: UITableViewController {
    
    var amount: Int?
    var amountString : String?
    var paymentMethod: [PaymentMethod] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "PaymentMethodCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "PaymentMethodCell")
        tableView.backgroundColor = UIColor.gray
        self.navigationItem.title = amountString
        self.navigationItem.prompt = "Amount"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
    
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if paymentMethod.count > 0 {
            return paymentMethod.count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if paymentMethod.count == 0 {
            return configureEmptyCell(indexPath: indexPath)
        } else {
            return configurePaymentMethodCell(indexPath: indexPath)
        }
    }
    
    func configurePaymentMethodCell(indexPath: IndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodCell
        cell.frame(forAlignmentRect: .zero)
        if let imageString = paymentMethod[indexPath.row].secureThumbnail {
            let url = URL(string: imageString)
            cell.cardImageView.kf.setImage(with: url)
        }
        return cell
    }
    
    
    
    func configureEmptyCell(indexPath: IndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodCell
        
        return cell
    }

    func getUseMoney (amountDouble: Double, f: Int = 2) -> String? {
        
        var stringAmount: String?
        
        let formatter = Foundation.NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = f
        formatter.maximumFractionDigits = f
        formatter.locale = Locale(identifier: "es_AR")
        
        stringAmount = formatter.string(from: NSNumber(value: amountDouble)) ?? "" // "$123.44"
        
        return stringAmount
    }

}


