//
//  Admin.swift
//  project-소스코드-1971324-전희연
//
//  Created by mac025 on 2022/06/09.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class Admin: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var tableViewItems = [String]()
    var tableViewDate = [String]()
    var name = [String]()
    var id = [String]()
    var call = [String]()
    var docId = [String]()
    var status = [String]()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as! ShowDetail
            if let row = tableview.indexPathForSelectedRow?.row{
                vc.docId = docId[row]
                print(vc.docId)
            }
        }
    }
    
    @IBAction func gotoMain(_ sender: UIButton) {
        performSegue(withIdentifier: "AdmintoMain", sender: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        
        let db = Firestore.firestore()
        db.collection("Umbrella").whereField("uid", isNotEqualTo: "").getDocuments() {(Snapshot, err) in
            if let err=err{
            }else{
                for document in Snapshot!.documents {
                    
                    db.collection("Umbrella").document(document.documentID).getDocument{(snapshot, err) in
                        if err == nil && snapshot != nil && snapshot!.data() != nil {
                            guard let date = (snapshot!.get("date")) else{
                                return
                            }
                            guard let name1 = (snapshot!.get("name")) else{
                                return
                            }
                            guard let call1 = (snapshot!.get("call")) else{
                                return
                            }
                            guard let id1 = (snapshot!.get("id")) else{
                                return
                            }
                            guard let item = (snapshot!.get("item")) else{
                                return
                            }
                            guard let status = (snapshot!.get("status")) else{
                                return
                            }
                            if (item as! String) == "U" {
                                self.tableViewItems.append("우산")
                            }else if (item as! String) == "C"{
                                self.tableViewItems.append("공학용 계산기")
                            }else{
                                self.tableViewItems.append("스피커")
                            }
                            self.tableViewDate.append(date as! String)
                            self.name.append(name1 as! String)
                            self.id.append(id1 as! String)
                            self.call.append(call1 as! String)
                            self.docId.append(document.documentID)
                            self.status.append(status as! String)
                            self.tableview.dataSource=self
                        }
                    }
                }
            }
        }

        super.viewDidLoad()
    }
}

extension Admin: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "AdminCell", for: indexPath)
        (cell.contentView.subviews[0] as! UILabel).text = name[indexPath.row]
        (cell.contentView.subviews[1] as! UILabel).text = id[indexPath.row]
        (cell.contentView.subviews[2] as! UILabel).text = call[indexPath.row]
        (cell.contentView.subviews[3] as! UILabel).text = tableViewItems[indexPath.row]
        (cell.contentView.subviews[4] as! UILabel).text = tableViewDate[indexPath.row]
        tableview.rowHeight = 100
        if status[indexPath.row]=="대기"{
            cell.backgroundColor=UIColor.yellow
        }else if status[indexPath.row]=="승인"{
            cell.backgroundColor=UIColor.systemYellow
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
}

