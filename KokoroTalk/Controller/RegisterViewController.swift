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
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var anniversaryTextField: UITextField!
    
    var datePicker:UIDatePicker = UIDatePicker()
    let animationView = AnimationView()
    var alertController:UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        //        ピッカーの設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        anniversaryTextField.inputView = datePicker
        //        決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))

        toolbar.setItems([spacelItem,doneItem], animated: true)
        //        インプットビュー設定
        anniversaryTextField.inputView = datePicker
        anniversaryTextField.inputAccessoryView = toolbar

    }
    
    @objc func done(){
        
        anniversaryTextField.endEditing(true)
    //        日時のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        anniversaryTextField.text = "\(formatter.string(from: datePicker.date))"
    }

    func calculateDate(){

        let cal = Calendar(identifier: .gregorian)
            // 現在日時を dt に代入

        let dt1 = Date()
        print(anniversaryTextField as Any)

            // 過去の日にち - dt1 を計算

        let diff1 = cal.dateComponents([.day], from: datePicker.date, to: dt1)

        print("差は \(diff1.day!) 日")
        anniversaryTextField.text = String(diff1.day!)
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "chat") as! ChatViewController
        nextVC.hartLabel = String(diff1.day!)
        navigationController?.pushViewController(nextVC, animated: true)

    }
    
    @IBAction func registerNewUser(_ sender: Any) {
//        firebaseにユーザーを登録する
//        アニメーションのスタート
        startAnimation()
//        新規登録
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil{
                print(error as Any)
//                アラートを出す
                self.alert(title: "error", message: "Email,Passwordをもう一度確認してください")
                self.stopAnimation()
            }else{
                print("Userの登録が完了しました")
//                アニメーションのストップ
                self.stopAnimation()
//                チャット画面に遷移させる
                self.calculateDate()
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
