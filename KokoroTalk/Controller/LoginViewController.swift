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
    @IBOutlet weak var userName: UITextField!
    let animationView = AnimationView()
    var alertController:UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        startAnimation()
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil{
                print(error as Any)
//                アラートを出す
                self.alert(title: "ログイン失敗", message: "Email,Passwordに誤りがあります")
                self.stopAnimation()
       
            }else{
                print("ログイン成功")
                self.stopAnimation()
//                self.performSegue(withIdentifier: "chat", sender: nil)
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "chat") as! ChatViewController
                nextVC.userNameLabel = self.userName.text!
                self.navigationController?.pushViewController(nextVC, animated: true)
                
                
            }
        }
    }

     func startAnimation(){
         let animation = Animation.named("loading")
        animationView.frame = CGRect(x: 80, y: 150, width: view.frame.size.width/1.5, height: view.frame.size.height/1.5)
    
         animationView.animation = animation
         animationView.contentMode = .scaleAspectFit
         animationView.loopMode = .loop
         animationView.play()
         view.addSubview(animationView)
     }
     func stopAnimation(){
         animationView.removeFromSuperview()
     }
    
    func alert(title:String,message:String){
        
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController,animated: true)
        
    }

}
