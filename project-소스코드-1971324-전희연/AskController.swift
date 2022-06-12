//
//  AskController.swift
//  project-소스코드-1971324-전희연
//
//  Created by mac025 on 2022/06/08.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class AskController: UIViewController {
    static let dateFormatter = DateFormatter()
    var secondText:String=""
    
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var call: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBAction func gotoMain(_ sender: UIButton) {
        performSegue(withIdentifier: "AsktoMain", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func FinAsk(_ sender: UIButton) {
        let db = Firestore.firestore()
        let uid =  UserDefaults.standard.string(forKey: "UUID")
        let Name = UserDefaults.standard.string(forKey: "name")
        let Id = UserDefaults.standard.string(forKey: "id")
        let Call = UserDefaults.standard.string(forKey: "call")
        db.collection("Umbrella").whereField("uid", isEqualTo: "").whereField("item", isEqualTo: secondText).limit(to:1).getDocuments(){ (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                            let formatter = DateFormatter() // DateFormatter클래스의 상수 선언
                            formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
                            let date1 = formatter.string(from: self.date.date)
                            db.collection("Umbrella").document(document.documentID).updateData(["uid": uid, "id":Id, "name":Name, "call":Call, "date":date1, "status":"대기"]) { err in
                                if let err = err {
                                    print("Error updating document: \(err)")
                                } else {
                                    print("Document successfully updated")
                                }
                            }
                        }
                    }
                }
        performSegue(withIdentifier: "finAsk", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if secondText=="U"{
            label.text="우산"
        }else if secondText=="C"{
            label.text="공학용계산기"
        }else{
            label.text="스피커"
        }
        self.name.text = UserDefaults.standard.string(forKey: "name")
        self.id.text = UserDefaults.standard.string(forKey: "id")
        self.call.text = UserDefaults.standard.string(forKey: "call")
    }
}
