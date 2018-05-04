//
//  AccountViewController.swift
//  Clother
//
//  Created by DSV on 2018-04-26.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
  
    var email: String? = nil
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ChangeEmailViewController = segue.destination as? ChangeEmailViewController{
            ChangeEmailViewController.email = email
        }
    }
    
    @IBAction func goToChangeEmailPage(_ sender: UIButton) {
        performSegue(withIdentifier: "goToChangeEmail", sender: sender)
    }
    
    @IBOutlet weak var userEmail: UILabel!
  

    @IBAction func goToMenuPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmail.text = email

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
