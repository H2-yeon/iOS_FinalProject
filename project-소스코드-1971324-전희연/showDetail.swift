//
//  showDetail.swift
//  project-소스코드-1971324-전희연
//
//  Created by mac025 on 2022/06/11.
//
import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class ShowDetail: UIViewController {
    var docId = ""
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var call: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBAction func deleteButtonTouch(_ sender: UIButton) {
        let db = Firestore.firestore()
        db.collection("Umbrella").document(docId).getDocument(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                db.collection("Umbrella").document(self.docId).updateData(["uid": "", "id":"", "name":"", "call":"", "date":"", "status":""]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        }
        performSegue(withIdentifier: "gotoDelete", sender: self)
    }
    
    @IBAction func applyButtonTouch(_ sender: UIButton) {
        let db = Firestore.firestore()
        db.collection("Umbrella").document(docId).getDocument(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                db.collection("Umbrella").document(self.docId).updateData(["status":"승인"]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        }
        performSegue(withIdentifier: "gotoApply", sender: self)
    }
    
    @IBAction func returnButtonTouch(_ sender: UIButton) {
        let db = Firestore.firestore()
        db.collection("Umbrella").document(docId).getDocument(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                db.collection("Umbrella").document(self.docId).updateData(["uid": "", "id":"", "name":"", "call":"", "date":"", "status":""]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        }
        performSegue(withIdentifier: "gotoReturn", sender: self)
    }
    
    override func viewDidLoad() {
        self.deleteButton.isEnabled=false
        self.applyButton.isEnabled=false
        self.returnButton.isEnabled=false
        self.deleteButton.isHidden=true
        self.applyButton.isHidden=true
        self.returnButton.isHidden=true
        super.viewDidLoad()
        print(docId)
        let db = Firestore.firestore()
        db.collection("Umbrella").document(docId).getDocument { (snapshot, error) in //관리자계정 확인
            if error == nil && snapshot != nil && snapshot!.data() != nil {
                guard let name = (snapshot!.get("name")) else{
                    return
                }
                guard let call = (snapshot!.get("call")) else{
                    return
                }
                guard let id = (snapshot!.get("id")) else{
                    return
                }
                guard let date = (snapshot!.get("date")) else{
                    return
                }
                guard let status = (snapshot!.get("status")) else{
                    return
                }
                self.name.text=name as! String
                self.id.text=id as! String
                self.call.text=call as! String
                self.date.text=date as! String
                self.status.text=status as! String
                if self.status.text=="대기"{
                    self.deleteButton.isHidden=false
                    self.applyButton.isHidden=false
                    self.deleteButton.isEnabled=true
                    self.applyButton.isEnabled=true
                }else if self.status.text=="승인"{
                    self.returnButton.isHidden=false
                    self.returnButton.isEnabled=true
                }
            }
        }
    }
}



