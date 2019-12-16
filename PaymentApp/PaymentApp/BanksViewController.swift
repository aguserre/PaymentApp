//
//  BanksViewController.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 13/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit

class BanksViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    enum CardState {
        case expanded
        case colapsed
    }
    
    var amount: Int?
    var amountString : String?
    var paymentMethod: PaymentMethodModel?
    private var cardIssuersArray: [CardIssuersModel]?
    private let picker = UIPickerView()
    private var pickerSelected: Int?
    private let segmentedControl = UISegmentedControl()
    @IBOutlet weak var bankTitleLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    
    private var cardViewDetailController: CardDetailViewController!
    private var visualEfectView: UIVisualEffectView!
    
    private let cardHeight: CGFloat = 300
    private let cardHandleAreaHeight: CGFloat = 65
    
    private var cardVisible = false
    var nextState: CardState {
        return cardVisible ? .colapsed : .expanded
    }
    
    private var runningAnimation = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.prompt = "Original amount"
        self.navigationItem.title = amountString
        let parameters = ["public_key":PUBLIC_KEY_API,
                        "payment_method_id": paymentMethod?.id ?? ""]
        let service = CardIssuersService()
        service.getCardIssuers(parameters: parameters) { (array) in
            self.cardIssuersArray = array
            self.setUpView(arrayCardIssuers: array)
        }
    }
    
    func setUpView(arrayCardIssuers: [CardIssuersModel]) {
        if arrayCardIssuers.count > 1 {
            if let firstName = arrayCardIssuers[0].name {
                self.bankLabel.text = firstName
                self.cardViewDetailController.bankName.text = firstName
            } else {
                self.bankLabel.text = "Select your Bank"
                self.cardViewDetailController.bankName.text = self.paymentMethod?.name
            }
            self.configurePickerView()
        } else {
            self.bankTitleLabel.text = "Your select"
            self.bankLabel.text = self.paymentMethod?.name
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let installmentsViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InstallmentsViewController") as? InstallmentsViewController
        installmentsViewController?.amount = amount
        installmentsViewController?.amountString = amountString
        installmentsViewController?.paymentMethod = paymentMethod
        
        if let select = pickerSelected {
            installmentsViewController?.cardIssuers = self.cardIssuersArray?[select]
        }
        navigationController?.pushViewController(installmentsViewController!, animated: true)
    }
    
    func configurePickerView(){
        self.picker.delegate = self
        self.picker.dataSource = self
        self.pickerSelected = 0
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        NSLayoutConstraint(item: picker, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: picker, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: bankLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 10).isActive = true
        
        NSLayoutConstraint(item: picker, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: view.bounds.width - 10).isActive = true
        NSLayoutConstraint(item: picker, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 180).isActive = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cardIssuersArray?.count ?? 2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if cardIssuersArray?.count == 0 {
            return paymentMethod?.name
        } else {
            if let bankName = cardIssuersArray?[row].name{
                return bankName
            } else {
                return "Not Bank support"
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if let bankName = cardIssuersArray?[row].name{
                bankLabel.text = bankName
                cardViewDetailController.bankName.text = bankName
                self.pickerSelected = row
            }
        self.pickerSelected = row
    }
    
    func setupCard(){
        visualEfectView = UIVisualEffectView()
        visualEfectView.frame = self.view.frame
        self.view.addSubview(visualEfectView)
        
        cardViewDetailController = CardDetailViewController(nibName: "CardDetailViewController", bundle: nil)
        self.addChild(cardViewDetailController)
        self.view.addSubview(cardViewDetailController.view)
        
        cardViewDetailController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        cardViewDetailController.view.clipsToBounds = true
        cardViewDetailController.amountLabel.text = self.amountString
        cardViewDetailController.methodLabel.text = self.paymentMethod?.name
        cardViewDetailController.bankName.text = self.paymentMethod?.name
        cardViewDetailController.rowImage.image = #imageLiteral(resourceName: "upButton")
        cardViewDetailController.buttonNext.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.configureVisualViews(view: cardViewDetailController.buttonNext, cornerRadius: 10, shadowOpacity: 0.8, shadowRadius: 5, shadowOffset: .zero, masksToBounds: false)
        self.configureVisualViews(view: cardViewDetailController.methodView, cornerRadius: 60, shadowOpacity: 0.8, shadowRadius: 10, shadowOffset: .zero, masksToBounds: false)
        self.configureVisualViews(view: cardViewDetailController.backRowImage, cornerRadius: 15, shadowOpacity: 0.8, shadowRadius: 5, shadowOffset: .zero, masksToBounds: false)
        self.configureVisualViews(view: cardViewDetailController.amountView, cornerRadius: 60, shadowOpacity: 0.8, shadowRadius: 10, shadowOffset: .zero, masksToBounds: false)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BanksViewController.handleCardTap(recognizer:)))
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(BanksViewController.handleCardPan(recognizer:)))
        
        cardViewDetailController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewDetailController.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    func configureVisualViews(view: UIView, cornerRadius: CGFloat, shadowOpacity: Float, shadowRadius: CGFloat, shadowOffset: CGSize, masksToBounds: Bool){
        view.layer.cornerRadius = cornerRadius
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowRadius = shadowRadius
        view.layer.masksToBounds = masksToBounds
    }
    
    @objc
    func handleCardTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
            case .ended:
                animationTransitionIsNeeded(state: nextState, duration: 0.9)
            default:
                break
            }
    }
    
    @objc
    func handleCardPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.cardViewDetailController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func animationTransitionIsNeeded(state: CardState, duration: TimeInterval){
        if runningAnimation.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state{
                case .expanded :
                    self.cardViewDetailController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                    self.cardViewDetailController.rowImage.image = #imageLiteral(resourceName: "downButton")
                case .colapsed :
                    self.cardViewDetailController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                    self.cardViewDetailController.rowImage.image = #imageLiteral(resourceName: "upButton")

                }
            }
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimation.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimation.append(frameAnimator)
            
            
            let cornerRadiusAnimator  = UIViewPropertyAnimator(duration: duration, curve: .linear){
                switch state{
                case .expanded :
                    self.cardViewDetailController.view.layer.cornerRadius = 12
                case .colapsed :
                    self.cardViewDetailController.view.layer.cornerRadius = 0

                }
            }
            cornerRadiusAnimator.startAnimation()
            runningAnimation.append(cornerRadiusAnimator)
            
            let blurAnimation = UIViewPropertyAnimator(duration: duration, dampingRatio: 1){
                switch state{
                case .expanded :
                    self.visualEfectView.effect = UIBlurEffect(style: .dark)
                case .colapsed :
                    self.visualEfectView.effect = nil
                }
            }
            blurAnimation.startAnimation()
            runningAnimation.append(blurAnimation)
        }
    }
    
    func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimation.isEmpty{
            animationTransitionIsNeeded(state: state, duration: duration)
        }
        for animator in runningAnimation {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimation {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition() {
        for animator in runningAnimation {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}
