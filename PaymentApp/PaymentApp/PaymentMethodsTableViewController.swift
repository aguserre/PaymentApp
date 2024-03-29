//
//  PaymentMethodsTableViewController.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 12/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import Kingfisher

class PaymentMethodsTableViewController: UITableViewController {
    
    lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    var amount: Int?
    var amountString : String?
    var paymentMethod: [PaymentMethodModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "PaymentMethodCell", bundle: nil)
        self.tableView.separatorColor = UIColor.clear
        self.tableView.register(nib, forCellReuseIdentifier: "PaymentMethodCell")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.navigationItem.prompt = "Original amount"
        self.navigationItem.title = amountString
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Analytics.logEvent("cellPaymentMethodTapped", parameters: ["method":paymentMethod[indexPath.row].name ?? ""])

        if paymentMethod.count == 0 {
            return
        } else {
            let banksViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BanksViewController") as? BanksViewController
            banksViewController?.amount = amount
            banksViewController?.amountString = amountString
            banksViewController?.paymentMethod = paymentMethod[indexPath.row]

            navigationController?.pushViewController(banksViewController!, animated: true)
            
        }
    }
    
    func configurePaymentMethodCell(indexPath: IndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodCell
        cell.frame(forAlignmentRect: .zero)
        if let imageString = paymentMethod[indexPath.row].secureThumbnail {
            let url = URL(string: imageString)
            cell.cardImageView.kf.setImage(with: url)
        }
        cell.titleMethodLabel.text = paymentMethod[indexPath.row].name
        
        let paymentTypeIdFormat = paymentMethod[indexPath.row].paymentTypeId?.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
        cell.typeMethodLabel.text = paymentTypeIdFormat?.uppercased()
        if paymentMethod[indexPath.row].paymentTypeId == "credit_card" {
            cell.acreditionTimeLabel.text = "Inmediatly"
        } else {
            cell.acreditionTimeLabel.text = "24/48 hs."
        }
        if let minAmount = paymentMethod[indexPath.row].minAllowedAmount{
            cell.minAllowedAmountLabel.text = intToCurrency(number: minAmount)
        }
        if let maxAmount = paymentMethod[indexPath.row].maxAllowedAmount{
            cell.maxAllowedAmountLabel.text = intToCurrency(number: maxAmount)
        }

        return cell
    }
    
    func configureEmptyCell(indexPath: IndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodCell
        //If service error, configure empty cell with error
        return cell
    }
    
    func intToCurrency(number: Int) -> String? {
        let stringAmount = Double(number/100) + Double(number%100)/100
        return numberFormatter.string(from: NSNumber(value: stringAmount))
    }
    
    
    
}


