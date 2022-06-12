//
//  My.swift
//  project-소스코드-1971324-전희연
//
//  Created by mac025 on 2022/06/09.
//
import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class My: UIViewController {
    

    @IBAction func gotoMain(_ sender: UIButton) {
        performSegue(withIdentifier: "MytoMain", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBOutlet weak var tableview: UITableView!
    var tableViewItems = [String]()
    var tableViewDate = [String]()
    var status = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        let uid =  UserDefaults.standard.string(forKey: "UUID")
        db.collection("Umbrella").whereField("uid", isEqualTo: uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    db.collection("Umbrella").document(document.documentID).getDocument { (snapshot, error) in
                        if error == nil && snapshot != nil && snapshot!.data() != nil {
                            guard let date = (snapshot!.get("date")) else{
                                return
                            }
                            guard let item = (snapshot!.get("item")) else{
                                return
                            }
                            guard let status = (snapshot!.get("status")) else{
                                return
                            }
                            if item as! String=="U"{
                                self.tableViewItems.append("우산")
                            }else if item as! String == "C"{
                                self.tableViewItems.append("공학용계산기")
                            }else{
                                self.tableViewItems.append("스피커")
                            }
                            self.tableViewDate.append(date as! String)
                            self.status.append(status as! String)
                            self.tableview.dataSource = self
                        }
                    }
                }
            }
        }
    }
}

extension My: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "AskCell", for: indexPath)
        (cell.contentView.subviews[0] as! UILabel).text = tableViewItems[indexPath.row]
        (cell.contentView.subviews[1] as! UILabel).text = tableViewDate[indexPath.row]
        cell.contentView.subviews[2].isHidden=true
        cell.contentView.subviews[3].isHidden=true
        cell.contentView.subviews[4].isHidden=true
        if tableViewItems[indexPath.row]=="우산"{
            cell.contentView.subviews[2].isHidden=false
        }else if tableViewItems[indexPath.row]=="공학용계산기"{
            cell.contentView.subviews[3].isHidden=false
        }else{
            cell.contentView.subviews[4].isHidden=false
        }
        tableview.rowHeight = 110
        return cell
    }
}
