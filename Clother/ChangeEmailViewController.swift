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
  
    @IBOutlet weak var currentUserEmail: UILabel!
    
  
    @IBOutlet weak var newEmail: UITextField!

    @IBOutlet weak var newPassword: UITextField!
    

    @IBAction func changeMailConfirmButton(_ sender: UIButton) {
        let email = newEmail.text
        let pass = newPassword.text
     let user = Auth.auth().currentUser
        user?.updateEmail(to: email!) { error in
            if let error = error {
                print(error)
                
            } else {
                // Email updated.
             //self.currentUserEmail.text = email
             user?.updatePassword(to: pass!) { error in
                    if let error = error {
                         print(error)
                    } else {
                        // Password updated.
                        print("success")

                }
            }
                
         }
               }
  let credential =  EmailAuthProvider.credential(withEmail: email!, password: pass!)
        user?.reauthenticate(with: credential) { error in
            if let error = error {
                print(error)
                // An error happened.
            } else {
                // User re-authenticated.
            
                
            }
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
        currentUserEmail.text = email
       
       
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
