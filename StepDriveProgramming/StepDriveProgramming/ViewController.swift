//
//  ViewController.swift
//  StepDriveProgramming
//
//  Created by alvin zheng on 17/10/12.
//  Copyright © 2017年 alvin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginGuid = LoginGuider()
        loginGuid.beginWithViewController(self)
        loginGuid.testRun()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

