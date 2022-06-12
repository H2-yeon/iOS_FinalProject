//
//  JoinCheck.swift
//  project-소스코드-1971324-전희연
//
//  Created by mac025 on 2022/06/07.
//

import UIKit

class JoinCheck: UIViewController {

    @IBAction func gotoStart(_ sender: UIButton) {
        performSegue(withIdentifier: "unwind", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
