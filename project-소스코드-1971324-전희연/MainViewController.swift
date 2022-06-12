//
//  MainViewController.swift
//  project-소스코드-1971324-전희연
//
//  Created by mac025 on 2022/06/08.
//
import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class MainViewController: UIViewController {
    @IBOutlet weak var Scount: UILabel!
    @IBOutlet weak var CButton: UIButton!
    @IBOutlet weak var Ccount: UILabel!
    @IBOutlet weak var Ucount: UILabel!
    @IBOutlet weak var adminImage: UIImageView!
    @IBOutlet weak var adminButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var UButton: UIButton!
    @IBOutlet weak var SButton: UIButton!
    
    @IBAction func gotoDetail(_ sender: UIButton) {
        performSegue(withIdentifier: "AskDetail", sender: self)
    }
    
    @IBAction func gotoAdmin(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoAdmin", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
      navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func UButton(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoUAsk", sender: self)
    }
    @IBAction func SButton(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoSAsk", sender: self)
    }
    @IBAction func CButton(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoCAsk", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoUAsk" {
            let vc = segue.destination as! AskController
            vc.secondText = "U"
        }
        if segue.identifier == "gotoCAsk" {
            let vc = segue.destination as! AskController
            vc.secondText = "C"
        }
        if segue.identifier == "gotoSAsk" {
            let vc = segue.destination as! AskController
            vc.secondText = "S"
        }
    }
    
    override func viewDidLoad() {
        if FirebaseApp.app() == nil {
          FirebaseApp.configure()
        }
        self.adminImage.isHidden=true
        self.adminButton.isEnabled=false
        
        let uid =  UserDefaults.standard.string(forKey: "UUID")
        let db = Firestore.firestore()
        
        db.collection("users").document(uid!).getDocument { (snapshot, error) in //관리자계정 확인
            if error == nil && snapshot != nil && snapshot!.data() != nil {
                guard let admin = (snapshot!.get("admin")) else{
                    return
                }
                if admin as! Bool==true{
                    self.adminImage.isHidden=false
                    self.adminButton.isEnabled=true
                }
            }
        }
        
        db.collection("Umbrella").whereField("uid", isEqualTo: "").whereField("item", isEqualTo: "U").getDocuments() { (querySnapshot, err) in //우산 개수 확인
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var count = 0
                for _ in querySnapshot!.documents {
                    count+=1
                }
                self.Ucount.text = String(count)
                if count==0{
                    self.Ucount.textColor = UIColor.lightGray
                    self.UButton.isEnabled=false
                    self.UButton.backgroundColor = UIColor.gray
                }
            }
        }
        db.collection("Umbrella").whereField("uid", isEqualTo: "").whereField("item", isEqualTo: "C").getDocuments() { (querySnapshot, err) in //우산 개수 확인
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var count = 0
                for _ in querySnapshot!.documents {
                    count+=1
                }
                self.Ccount.text = String(count)
                if count==0{
                    self.Ccount.textColor = UIColor.lightGray
                    self.CButton.isEnabled=false
                    self.CButton.backgroundColor = UIColor.gray
                }
            }
        }
        db.collection("Umbrella").whereField("uid", isEqualTo: "").whereField("item", isEqualTo: "S").getDocuments() { (querySnapshot, err) in //우산 개수 확인
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        var count = 0
                        for _ in querySnapshot!.documents {
                            count+=1
                        }
                        self.Scount.text = String(count)
                        if count==0{
                            self.Scount.textColor = UIColor.lightGray
                            self.SButton.isEnabled=false
                            self.SButton.backgroundColor = UIColor.gray
                        }
                    }
                }
        
        super.viewDidLoad()
    }
}
