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
    @IBOutlet weak var backgroundLottieView: UIView!
    @IBOutlet weak var successAnimation: UIView!
    @IBOutlet weak var goHomeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goHomeButton.isHidden = true
        titleLabel.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        playAnimation()
    }
    
    func playAnimation(){
        
        let animationLottie = LOTAnimationView(name: "successAnimation")
        animationLottie.frame = successAnimation.frame
        successAnimation.addSubview(animationLottie)
        animationLottie.play(completion: { finished in
            print(finished)
            self.setView(view: self.goHomeButton, hidden: false)
            self.setView(view: self.titleLabel, hidden: false)

            
        })
        animationLottie.loopAnimation = false
        
        
        
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    @IBAction func goHome(_ sender: Any) {
        print("go home")

    }
    
}
