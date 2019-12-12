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
    var paymentMethod: [PaymentMethod] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "PaymentMethodCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "PaymentMethodCell")
        tableView.backgroundColor = UIColor.gray
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}