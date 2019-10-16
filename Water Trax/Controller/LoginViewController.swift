//
//  ViewController.swift
//  Water Trax
//
//  Created by David Jin on 15/10/19.
//  Copyright © 2019 DJAY. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        promptForLogin()
      }
func promptForLogin() {
  let UsernameAlert = UIAlertController(title: "Login", message: "This is your name for your account", preferredStyle: .alert)
      UsernameAlert.addTextField { (UITextField) in
      UITextField.self.placeholder = "Username"
      UITextField.self.keyboardType = .default
      UITextField.self.keyboardAppearance = .dark
  }

  let continueAction = UIAlertAction(title: "Continue", style: .default) { [unowned UsernameAlert] _ in
    let username = UsernameAlert.textFields![0]
    print(username.text!)
    
    if (username.text! == "DJAY") {
        self.promptForPassword()
    }
    else{
        self.promptForLogin()
    }
    
    
  }
  let signUpAction = UIAlertAction(title: "Sign up", style: .default) { [] _ in
      self.promptForLogin()
  }
      
  UsernameAlert.addAction(signUpAction)
  UsernameAlert.addAction(continueAction)


  present(UsernameAlert, animated: true)
  }

    func promptForPassword() {
        let PasswordAlert = UIAlertController(title: "Login", message: "This is the password for your account", preferredStyle: .alert)
        
            PasswordAlert.addTextField { (UITextField) in
            UITextField.self.placeholder = "Password"
            UITextField.self.keyboardType = .default
            UITextField.self.keyboardAppearance = .dark
        }

        let submitAction = UIAlertAction(title: "Continue", style: .default) { [unowned PasswordAlert] _ in
          let password = PasswordAlert.textFields![0]
          print(password.text!)
          
          if (password.text! == "12345") {
              print("Successfully Logged In")
            self.performSegue(withIdentifier: "goToHome", sender: self)
          }
          else{
            self.promptForPassword()
            }
          
          
        }
        let backAction = UIAlertAction(title: "back", style: .default) { [] _ in
            self.promptForLogin()
        }
            
        PasswordAlert.addAction(backAction)
        PasswordAlert.addAction(submitAction)
        present(PasswordAlert, animated: true)
    }
    
    
    
    
    
    
}
