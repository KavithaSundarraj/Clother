//
//  CreateViewController.swift
//  Clother
//
//  Created by DSV on 2018-04-16.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit
//importing firebase
import Firebase

class CreateViewController: UIViewController {
    
    // Outlet for Email and Password field
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    //Back Button - to connect to Main Page
    @IBAction func goToMainPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //Create Button - Create new user with email and password and perform segue to Menu page
    @IBAction func createButton(_ sender: UIButton) {
        //if email textfield is empty - create alert
        if EmailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
        }
        else {
            Auth.auth().createUser(withEmail: EmailTextField.text!, password: PasswordTextField.text!, completion: { (user: User?, error) in
            if error == nil {
                print("success")
                print(User.self)
                self.performSegue(withIdentifier: "createSegue", sender: self)
            }
            else{
                //To alert based on error
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                //To reset textfields
                self.EmailTextField.text=""
                self.PasswordTextField.text=""
                }
                })
               }
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
