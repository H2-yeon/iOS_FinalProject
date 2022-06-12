//
//  finApply.swift
//  project-소스코드-1971324-전희연
//
//  Created by mac025 on 2022/06/12.
//

import UIKit

class finApply: UIViewController {

    @IBAction func gotoMain(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoAdmin2", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
