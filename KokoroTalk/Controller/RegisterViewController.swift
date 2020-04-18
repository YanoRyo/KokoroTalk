//
//  RegisterViewController.swift
//  KokoroTalk
//
//  Created by 矢野涼 on 2020-04-16.
//  Copyright © 2020 Ryo Yano. All rights reserved.
//

import UIKit
import Firebase
import Lottie

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let animationView = AnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerNewUser(_ sender: Any) {
//        firebaseにユーザーを登録する
//        アニメーションのスタート
        startAnimation()
//        新規登録
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil{
                print(error as Any)
            }else{
                print("Userの登録が完了しました")
//                アニメーションのストップ
                self.stopAnimation()
//                チャット画面に遷移させる
                self.performSegue(withIdentifier: "chat", sender: nil)
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

}
