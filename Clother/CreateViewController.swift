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
    
    //Back Button - to connect to Main Page
    @IBAction func goToMainPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // Outlet for Email and Password field
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    //Outlet for Message field
    @IBOutlet weak var MessageLabel: UILabel!
    
    //Prepare method in Segue to transfer Email
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let MenuViewController = segue.destination as? MenuViewController{
            MenuViewController.email = EmailTextField.text
        }
    }
    
    //Create Button - Create new user with amail and password and perform segue to Menu page
    @IBAction func createButton(_ sender: UIButton) {
        //do the registration operation here
        
        //first take the email and password from the views
        let email = EmailTextField.text
        let password = PasswordTextField.text
        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user: User?, error) in
            if error == nil {
                
                self.performSegue(withIdentifier: "createSegue", sender: self)
                //self.MessageLabel.text = "You are successfully registered"
            }else{
                self.MessageLabel.text = "Registration Failed.. Please Try Again"
        
                self.EmailTextField.text=""
                self.PasswordTextField.text=""
                
            }
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // To display title at Navigation bar
        self.title = " Clother"
        //initialising firebase
        FirebaseApp.configure()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
