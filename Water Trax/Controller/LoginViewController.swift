//
//  ViewController.swift
//  Water Trax
//
//  Created by David Jin on 15/10/19.
//  Copyright © 2019 DJAY. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {
    let realm = try! Realm()
    var signUpUsername = String()
    var logInUserArrayPosition : Int = 0
    var userArray: Results<User>?
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        
        loadUsers()
        logInUserArrayPosition = 0
        
        if userArray!.count == 0 {
            print("yep its nil")
            let admin = User()
            admin.username = "DJAY"
            admin.password = "12345"
            save(user: admin)
        }
        
        waitThenPromp(prompt: "Username")
      }
    
    override func viewWillAppear(_ animated: Bool) {
              self.navigationController?.isNavigationBarHidden = true
          }
    
    
func promptForLogin() {
  let UsernameAlert = UIAlertController(title: "Login", message: "This is the name for your account", preferredStyle: .alert)
      UsernameAlert.addTextField { (UITextField) in
      UITextField.self.placeholder = "Username"
      UITextField.self.keyboardType = .default
      UITextField.self.keyboardAppearance = .dark
        
  }

  let continueAction = UIAlertAction(title: "Continue", style: .default) { [unowned UsernameAlert] _ in
    let username = UsernameAlert.textFields![0]
    var correctUsername : Bool = false

    
        if self.userArray != nil {
            for user in self.userArray! {
                if user.username == username.text! {
                    print(self.logInUserArrayPosition)
                    print(user.username)
                    correctUsername = true
                    self.dismiss(animated: true) {
                        self.promptForPassword()
                        
                    }
                                        
                }
                if correctUsername != true{
                self.logInUserArrayPosition += 1
                    print("User array position added 1 while on \(user.username)")
                    print(self.logInUserArrayPosition)
                
                
                }
            }
            if correctUsername != true {
                self.waitThenPromp(prompt: "Username")
            }
        }
        
 
    
    
    
  }
  let signUpAction = UIAlertAction(title: "Sign up", style: .default) { [] _ in
    self.waitThenPromp(prompt: "NewUsername")
  }
      
  UsernameAlert.addAction(signUpAction)
  UsernameAlert.addAction(continueAction)


  present(UsernameAlert, animated: true)
  }

    
    
    func promptForPassword() {
        let PasswordAlert = UIAlertController(title: "Login", message: "Enter your accounts password", preferredStyle: .alert)
        
            PasswordAlert.addTextField { (UITextField) in
            UITextField.self.placeholder = "Password"
            UITextField.self.keyboardType = .default
            UITextField.self.keyboardAppearance = .dark
        }

        let submitAction = UIAlertAction(title: "Continue", style: .default) { [unowned PasswordAlert] _ in
          let password = PasswordAlert.textFields![0]
          print(password.text!)
            
                let correctPassword = self.userArray?[self.logInUserArrayPosition].password
                if password.text == correctPassword{
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
                    print (self.logInUserArrayPosition)
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                } else {
                    self.waitThenPromp(prompt: "Password")
                }
           
            
        }
        
       
        
        
        
        let backAction = UIAlertAction(title: "back", style: .default) { [] _ in
            self.logInUserArrayPosition = -1
            self.waitThenPromp(prompt: "Username")
        }
            
        PasswordAlert.addAction(backAction)
        PasswordAlert.addAction(submitAction)
        present(PasswordAlert, animated: true)
    }
    
    
    
    
    
    
    func promptForSignUp() {
    let UsernameAlert = UIAlertController(title: "Sign up", message: "This is your name for your new account", preferredStyle: .alert)
        UsernameAlert.addTextField { (UITextField) in
        UITextField.self.placeholder = "Username"
        UITextField.self.keyboardType = .default
        UITextField.self.keyboardAppearance = .dark
          
    }

    let continueAction = UIAlertAction(title: "Continue", style: .default) { [unowned UsernameAlert] _ in
      let username = UsernameAlert.textFields![0]
        self.signUpUsername = username.text!
        self.waitThenPromp(prompt: "NewPassword")
      
      
      
      
    }
    let loginAction = UIAlertAction(title: "Login", style: .default) { [] _ in
        self.waitThenPromp(prompt: "Username")
    }
        
    UsernameAlert.addAction(loginAction)
    UsernameAlert.addAction(continueAction)


    present(UsernameAlert, animated: true)
    }

      func promptForNewPassword() {
          let PasswordAlert = UIAlertController(title: "Login", message: "This is the password for your account", preferredStyle: .alert)
          
              PasswordAlert.addTextField { (UITextField) in
              UITextField.self.placeholder = "Password"
              UITextField.self.keyboardType = .default
              UITextField.self.keyboardAppearance = .dark
          }

          let createAction = UIAlertAction(title: "Create", style: .default) { [unowned PasswordAlert] _ in
            let password = PasswordAlert.textFields![0]
            
            let newUser = User()
            newUser.username = self.signUpUsername
            newUser.password = password.text!
            self.save(user: newUser)
            self.logInUserArrayPosition = self.userArray!.count - 1
            
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
            self.performSegue(withIdentifier: "goToHome", sender: self)
            
            
          }
          let backAction = UIAlertAction(title: "back", style: .default) { [] _ in
              self.waitThenPromp(prompt: "NewUsername")
          }
              
          PasswordAlert.addAction(backAction)
          PasswordAlert.addAction(createAction)
          present(PasswordAlert, animated: true)
      }
    
    
    
    
    func loadUsers() {
        
        userArray = realm.objects(User.self)
        
    }
    func save(user : User) {
           do {
               try realm.write {
                   realm.add(user)
               }
           } catch {
               print("Error saving user \(error)")
           }
           
           
           
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // if let destinationVC = segue.destination as? UINavigationController{
        //let HousesTableViewController = destinationVC.topViewController as! HousesTableViewController
           // Your preparation code here
           // HousesTableViewController.selectedUser = self.userArray![logInUserArrayPosition]
            
        //}
       
        let destinationVC = segue.destination as! HousesTableViewController
            destinationVC.selectedUser = self.userArray![logInUserArrayPosition]
        
    }
    
    func waitThenPromp(prompt : String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Put your code which should be executed with a delay here
            if prompt == "NewPassword" {
                self.promptForNewPassword()
            }
            if prompt == "Password" {
                self.promptForPassword()
            }
            if prompt == "NewUsername" {
                self.promptForSignUp()
            }
            if prompt == "Username" {
                self.promptForLogin()
            }
        
        
        }
    }
    
    
    
    
}
