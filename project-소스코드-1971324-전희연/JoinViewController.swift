//
//  JoinViewController.swift
//  project-소스코드-1971324-전희연
//
//  Created by mac025 on 2022/06/07.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class JoinViewController: UIViewController {

    @IBOutlet weak var idCheck: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var callTextField: UITextField!
    @IBAction func Register(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "JoinCheck", sender: self)
        if let id = idTextField.text, let passwd = pwTextField.text{
            let name = nameTextField.text
            let call = callTextField.text
            let email = id + "@hansung.ac.kr"
            Auth.auth().createUser(withEmail: email, password: passwd){ (user, error) in
                if user != nil{
                    print("register success")
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    let db = Firestore.firestore()
                    db.collection("users").document(userID).setData(["id":id, "name":name, "call":call, "admin": false])
                    self.performSegue(withIdentifier: "JoinCheck", sender: self)
                } else {
                    self.idCheck.isHidden=false
                    print("register failed")
                    
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        idCheck.isHidden = true
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard(sender: UITapGestureRecognizer){
        pwTextField.resignFirstResponder()
        idTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        callTextField.resignFirstResponder()
    }


}
