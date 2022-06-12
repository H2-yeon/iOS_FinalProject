//
//  LoginViewController.swift
//  project-소스코드-1971324-전희연
//
//  Created by mac025 on 2022/06/07.
//
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var checkLogin: UILabel!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if FirebaseApp.app() == nil {
          FirebaseApp.configure()
        }
        checkLogin.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func gotoMain(_ sender: UIButton) {
        if let id = idTextField.text, let passwd = pwTextField.text{
            let email = id + "@hansung.ac.kr"
            
            Auth.auth().signIn(withEmail: email, password: passwd) { result, error in
                if let error = error{
                    print("Login Error: \(error)")
                    self.checkLogin.isHidden = false
                    return
                }
                guard let userID = Auth.auth().currentUser?.uid else { return }
                UserDefaults.standard.set(userID, forKey: "UUID")
                let db = Firestore.firestore()
                db.collection("users").document(userID).getDocument { (snapshot, error) in
                    if error == nil && snapshot != nil && snapshot!.data() != nil {
                        guard let name1 = (snapshot!.get("name")) else{
                            return
                        }
                        guard let id1 = (snapshot!.get("id")) else{
                            return
                        }
                        guard let call1 = (snapshot!.get("call")) else{
                            return
                        }
                        UserDefaults.standard.set(name1 as! String, forKey: "name")
                        UserDefaults.standard.set(id1 as! String, forKey: "id")
                        UserDefaults.standard.set(call1 as! String, forKey: "call")
                    }
                }
                self.performSegue(withIdentifier: "gotoMain", sender: self)
                print("Login Success")
            }
        }

    }
    @objc func dismissKeyboard(sender: UITapGestureRecognizer){
        pwTextField.resignFirstResponder()
        idTextField.resignFirstResponder()
    }

}
