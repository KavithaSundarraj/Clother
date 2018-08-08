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
    
    //Sign In Button - To validate user email and password and perform segue to connect Menu Page
    @IBAction func signIn(_ sender: UIButton) {
        let email = emailTextFieldName.text
        let password = passwordTextField.text
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user: User?, error) in
            if error == nil {
                self.performSegue(withIdentifier: "goToMenuPage", sender: self)
            }else{
                //To perform alert message based on error
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                //To reset the textfields to empty
                self.emailTextFieldName.text = ""
                self.passwordTextField.text = ""
            }
        })
    }
    
    //Back Button - to connect to Main page
    @IBAction func goToMainPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //Function to dismiss keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //or
        //self.view.endEditing(true)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialising firebase
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
