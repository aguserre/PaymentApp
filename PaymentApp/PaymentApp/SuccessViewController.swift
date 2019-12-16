//
//  SuccessViewController.swift
//  PaymentApp
//
//  Created by Agustin Errecalde on 15/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit
import TinyConstraints
import Lottie

class SuccessViewController: UIViewController {
    
    // to force error select Tarjeta Shopping
    var error = false
    
    @IBOutlet weak var backgroundLottieView: UIView!
    @IBOutlet weak var successAnimation: UIView!
    @IBOutlet weak var goHomeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goHomeButton.isHidden = true
        titleLabel.isHidden = true
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        playAnimation()
    }
    
    func playAnimation(){
        var animationName = ""
        if error {
            animationName = "errorAnimation"
            titleLabel.text = "An error ocurred!"
            goHomeButton.titleLabel?.text = "Try again"
        } else {
            animationName = "successAnimation"
        }
        
        let animation = LOTAnimationView(name: animationName)
        animation.frame = successAnimation.frame
        successAnimation.addSubview(animation)
        animation.play(completion: { finished in
            print(finished)
            self.setView(view: self.goHomeButton, hidden: false)
            self.setView(view: self.titleLabel, hidden: false)
        })
        animation.loopAnimation = false
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    @IBAction func goHome(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
