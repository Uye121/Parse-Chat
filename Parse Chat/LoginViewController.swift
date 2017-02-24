//
//  LoginViewController.swift
//  Parse Chat
//
//  Created by Ulric Ye on 2/23/17.
//  Copyright © 2017 uye. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        let user = PFUser()
        user.username = self.usernameField.text
        user.password = self.passwordInput.text
        
        user.signUpInBackground { (suceeed, error) in
            if let error = error {
                print("fail")
            } else {
                
            }
        }
    }
    
    @IBAction func logIn(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordInput.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if let error = error {
                print("User login failed.")
                print(error.localizedDescription)
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func error() {
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        
        // create a cancel action
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
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
