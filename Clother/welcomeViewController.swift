//
//  welcomeViewController.swift
//  Clother
//
//  Created by DSV on 2018-07-02.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit

class welcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Display welcome page for 2 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.performSegue(withIdentifier: "welcomeSeguetoMenu", sender: self)
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
