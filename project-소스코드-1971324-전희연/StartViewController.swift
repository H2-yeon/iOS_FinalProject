//
//  StartViewController.swift
//  project-소스코드-1971324-전희연
//
//  Created by mac025 on 2022/06/07.
//

import UIKit

class StartViewController: UIViewController {

    @IBAction func LoginTouch(_ sender: UIButton) {
        performSegue(withIdentifier: "Login", sender: self)
    }
    @IBAction func JoinTouch(_ sender: UIButton) {
        performSegue(withIdentifier: "Join", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func unwindVC1 (segue : UIStoryboardSegue) {}
}
