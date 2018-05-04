//
//  LoginViewController.swift
//  Clother
//
//  Created by DSV on 2018-04-16.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    //Textfields for email and password
    @IBOutlet weak var emailTextFieldName: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //Label for displaying message
    @IBOutlet weak var messageLabel: UILabel!

    //Prepare method in Segue to transfer Email
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let MenuViewController = segue.destination as? MenuViewController{
            MenuViewController.email = emailTextFieldName.text
        }
    }
    
    //Sign In Button - To validate user email and password and perform segue to connect Menu Page
    @IBAction func signIn(_ sender: UIButton) {
        let email = emailTextFieldName.text
        let password = passwordTextField.text
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user: User?, error) in
            if error == nil {
                self.messageLabel.text = "VALID USER"
                self.performSegue(withIdentifier: "goToMenuPage", sender: self)
            }else{
                self.messageLabel.text = "INVALID USER, PLEASE TRY AGAIN"
                self.emailTextFieldName.text = " "
                self.passwordTextField.text = " "
            }
            
        })
    }
    
    //Back Button - to connect to Main page
    @IBAction func goToMainPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = " Clother"
        //initialising firebase
        FirebaseApp.configure()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
