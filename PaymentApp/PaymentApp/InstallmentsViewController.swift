//
//  InstallmentsViewController.swift
//  PaymentApp
//
//  Created by Agustin Errecalde on 14/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit
import TinyConstraints

class InstallmentsViewController: UIViewController {
    
    var amount: Int?
    var amountString : String?
    var paymentMethod: PaymentMethodModel?
    var cardIssuers: CardIssuersModel?
    var installments: InstallmentModel?
    var installmentsCount: [String] = []
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var installmentResumeLabel: UILabel!
    @IBOutlet weak var tnaLabel: UILabel!
    @IBOutlet weak var amountWhithTnaLabel: UILabel!
    
    lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: self.installmentsCount)
        control.selectedSegmentIndex = 0
        control.layer.cornerRadius = 9
        control.layer.borderWidth = 1
        control.layer.masksToBounds = true
        if #available(iOS 13.0, *) {
            control.layer.borderColor = UIColor.systemIndigo.cgColor
        } else {
            control.layer.borderColor = UIColor.black.cgColor
        }
        control.addTarget(self, action: #selector(changeValueSc(sender:)), for: .valueChanged)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installmentResumeLabel.text = amountString

        let parameters = ["public_key":PUBLIC_KEY_API,
                        "payment_method_id": paymentMethod?.id ?? ""]
        let service = InstallmentsService()
        
        service.getInstallments(parameters: parameters) { (installment) in
            self.installments = installment
            if let playerCostsArray = installment.payerCosts {

                for i in 0 ..< playerCostsArray.count{
                    if let numberInstallment = playerCostsArray[i].installments{
                        let numberString = String(numberInstallment)
                        self.installmentsCount.append(numberString)
                    }
                }
                self.sc()
            }
        }
    }
    
    fileprivate func sc(){
        view.addSubview(segmentedControl)
        segmentedControl.height(30)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: segmentedControl, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: segmentedControl, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleLabel, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 50).isActive = true
        
        NSLayoutConstraint(item: segmentedControl, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: view.bounds.width - 30).isActive = true
        NSLayoutConstraint(item: segmentedControl, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100).isActive = true
    }
    
    @objc
    func changeValueSc(sender: UISegmentedControl) {

        if let installmentCount = self.installments?.payerCosts?[sender.selectedSegmentIndex].installments,
            let amountRate = self.installments?.payerCosts?[sender.selectedSegmentIndex].installmentRate,
            let tnaInfo = self.installments?.payerCosts?[sender.selectedSegmentIndex].labels {
            
            let amountDouble: Double
            var amountRateDouble = Double(amountRate)
            
            let totalInstallment: Double
            let totalAmount: Double
            
            if let amount = amount {
                amountRateDouble = amountRateDouble/100
                amountDouble = Double(amount/100) + Double(amount%100)/100
                
                totalInstallment = (amountDouble + (amountDouble * amountRateDouble)) / Double(installmentCount)
                if let installmentTotal = numberFormatter.string(from: NSNumber(value: totalInstallment)){
                    installmentResumeLabel.text = "\(installmentCount) x " + installmentTotal
                }
                
                totalAmount = (amountDouble + (amountDouble * amountRateDouble))
                if let amountTotal = numberFormatter.string(from: NSNumber(value: totalAmount)){
                    amountWhithTnaLabel.text = "Total: " + amountTotal
                }
                
                for i in tnaInfo {
                    if i.contains("CFT"){
                        tnaLabel.text = i
                    }
                }
                
            }
        }
    }

}
