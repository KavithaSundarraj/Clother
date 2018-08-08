//
//  AccountViewController.swift
//  Clother
//
//  Created by DSV on 2018-04-26.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {
  
    var email: String? = nil
    let user = Auth.auth().currentUser
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ChangeEmailViewController = segue.destination as? ChangeEmailViewController{
            ChangeEmailViewController.email = email
        }
    }*/
    
    @IBAction func LogOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "LogOutSegue", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    @IBAction func goToChangeEmailPage(_ sender: UIButton) {
        performSegue(withIdentifier: "goToChangeEmail", sender: sender)
    }
    
    @IBAction func goToChangePasswordPage(_ sender: UIButton) {
        performSegue(withIdentifier: "goToChangePassword", sender: sender)
    }
    
    @IBOutlet weak var userEmail: UILabel!
  

    @IBAction func goToMenuPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
 
    override func viewDidLoad() {
        
        super.viewDidLoad()
        super.viewDidLoad()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        userEmail.text = user?.email

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
