//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Ryan M on 5/12/19.
//  Copyright © 2019 Ryan M. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                self.displayLoginError(error: error!)
            }
        }
    }
    
    @IBAction func onSignup(_ sender: Any) {
        if usernameAndPasswordNotEmpty() {
            let user = PFUser()
            user.username = usernameField.text
            user.password = passwordField.text
    //        user.email = "email@example.com"
    //        // other fields can be set just like with PFObject
    //        user["phone"] = "415-392-0202"
            
            user.signUpInBackground { (success, error) in
                if success {
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
                else {
                    self.displaySignupError(error: error!)
                }
            }
        }
    }
    
    //Funcs for Errors
    
    func usernameAndPasswordNotEmpty() -> Bool {
        // Check text field inputs
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty {
            displayEmptyError()
            return false
        } else {
            return true
        }
    }
    
    func displayEmptyError() {
        let title = "Error"
        let message = "Username and password field cannot be empty"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    
    // Login error alert controller
    func displayLoginError(error: Error) {
        let title = "Login Error"
        let message = "Oops! Something went wrong while logging in: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    
    // Sign up error alert controller
    func displaySignupError(error: Error) {
        let title = "Sign up error"
        let message = "Oops! Something went wrong while signing up"
        print("Signup Error: \(error.localizedDescription)")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }

}
