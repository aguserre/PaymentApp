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
    private var installments: InstallmentModel?
    private var installmentsCount: [String] = []
    private var service = InstallmentsService()

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var installmentResumeLabel: UILabel!
    @IBOutlet weak var tnaLabel: UILabel!
    @IBOutlet weak var amountWhithTnaLabel: UILabel!
    
    @IBOutlet weak var resumeBackgroundTitleView: UIView!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var installmentsCountLabel: UILabel!
    @IBOutlet weak var totalPayLabel: UILabel!
    
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
        self.navigationItem.prompt = "Amount"
        self.navigationItem.title = amountString
        setUpResumeView()
        setUpLabels()
        
        let parameters = ["public_key":PUBLIC_KEY_API,
                        "payment_method_id": paymentMethod?.id ?? ""]
        service.getInstallments(parameters: parameters) { (installment) in
            self.installments = installment
            if let playerCostsArray = installment.payerCosts {

                for i in 0 ..< playerCostsArray.count{
                    if let numberInstallment = playerCostsArray[i].installments{
                        let numberString = String(numberInstallment)
                        self.installmentsCount.append(numberString)
                    }
                }
                self.setUpSegmentedControl()
            }
        }
    }
    
    fileprivate func setUpSegmentedControl(){
        view.addSubview(segmentedControl)
        segmentedControl.height(30)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        //constraints
        NSLayoutConstraint(item: segmentedControl, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: segmentedControl, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleLabel, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 50).isActive = true
        
        NSLayoutConstraint(item: segmentedControl, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: view.bounds.width - 100).isActive = true
        NSLayoutConstraint(item: segmentedControl, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100).isActive = true
    }
    
    @IBAction func goToSuccessBtn(_ sender: Any) {
        let succesViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController
        //select Tarjeta Shopping to force error view
        if paymentMethod?.name == "Tarjeta Shopping"{
            succesViewController?.error = true
        }
        navigationController?.pushViewController(succesViewController!, animated: true)
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
                    installmentsCountLabel.text = "\(installmentCount) x " + installmentTotal
                }
                
                totalAmount = (amountDouble + (amountDouble * amountRateDouble))
                if let amountTotal = numberFormatter.string(from: NSNumber(value: totalAmount)){
                    amountWhithTnaLabel.text = "Total: " + amountTotal
                    totalPayLabel.text = "Total: " + amountTotal
                }
                
                for i in tnaInfo {
                    if i.contains("CFT"){
                        tnaLabel.text = i
                    }
                }
                
            } else {
                //handle second error (mount)

            }
        } else {
            //handle first error
        }
    }
    
    func setUpResumeView(){
        resumeBackgroundTitleView.layer.cornerRadius = 20
        resumeBackgroundTitleView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        resumeBackgroundTitleView.layer.shadowOpacity = 10
        resumeBackgroundTitleView.layer.shadowOffset = .zero
        resumeBackgroundTitleView.layer.shadowRadius = 10
        resumeBackgroundTitleView.layer.masksToBounds = true
    }
    
    func setUpLabels(){
        bankName.text = paymentMethod?.name?.uppercased()
        let paymentTypeIdFormat = paymentMethod?.paymentTypeId?.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
        paymentMethodLabel.text = paymentTypeIdFormat?.uppercased()
        installmentResumeLabel.text = amountString
        
        if let amountString = amountString {
            installmentResumeLabel.text = "1 x " + amountString
            installmentsCountLabel.text = "1 x " + amountString.uppercased()

            amountWhithTnaLabel.text = "Total: " + amountString
            totalPayLabel.text = "Total: " + amountString.uppercased()
        }
        tnaLabel.text = "CFT_0,00%|TEA_0,00%"
    }
}
