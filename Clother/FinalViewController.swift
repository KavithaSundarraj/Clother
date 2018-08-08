//
//  FinalViewController.swift
//  Clother
//
//  Created by DSV on 2018-05-23.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    
    //Button to perform segue  - to go to Menu page
    @IBAction func exploreCollectionsButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "exploreCollectionsSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
