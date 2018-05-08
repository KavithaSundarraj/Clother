//
//  ChangeEmailViewController.swift
//  Clother
//
//  Created by DSV on 2018-04-27.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit
import Firebase

class ChangeEmailViewController: UIViewController {
    var email: String? = nil
    let user = Auth.auth().currentUser
    @IBOutlet weak var currentUserEmail: UILabel!
    
  
    @IBOutlet weak var newEmail: UITextField!


    @IBOutlet weak var repeatEmail: UITextField!
    

    @IBAction func changeMailConfirmButton(_ sender: UIButton) {
        let email = newEmail.text
        let remail = repeatEmail.text
        
        if email == remail
        {
        user?.updateEmail(to: email!) { error in
            if let error = error {
                print(error)
                print("Email updation Failure")
                
            } else {
              print("Email updation success")
                let alert = UIAlertController(title: "Email Changed", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continue", style: .default){
                    UIAlertAction in
                    // Insert code to run on button click below
                    self.dismiss(animated: true, completion: nil)
                })
                self.present(alert, animated: true)
                
            }
            }
            
        }
     else
        {
            let alert = UIAlertController(title: "Email Mismatch", message: "Please Re-Enter Email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.newEmail.text = ""
            self.repeatEmail.text = ""
            
        }

 
        
    }
    
 
    @IBAction func goBackAccountPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        currentUserEmail.text = user?.email
       
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
