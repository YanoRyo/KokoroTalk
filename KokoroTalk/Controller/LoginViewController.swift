//
//  LoginViewController.swift
//  KokoroTalk
//
//  Created by 矢野涼 on 2020-04-17.
//  Copyright © 2020 Ryo Yano. All rights reserved.
//

import UIKit
import Firebase
import Lottie

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        startAnimation()
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil{
                print(error as Any)
            }else{
                print("ログイン成功")
                self.stopAnimation()
                self.performSegue(withIdentifier: "chat", sender: nil)
                
            }
        }
    }
    
     func startAnimation(){
         let animation = Animation.named("loading")
         animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width/2, height: view.frame.size.height/2)
    
         animationView.animation = animation
         animationView.contentMode = .scaleAspectFit
         animationView.loopMode = .loop
         animationView.play()
         view.addSubview(animationView)
     }
     func stopAnimation(){
         animationView.removeFromSuperview()
     }

}
