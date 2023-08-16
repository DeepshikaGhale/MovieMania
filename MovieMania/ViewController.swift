//
//  ViewController.swift
//  MovieMania
//
//  Created by Deepshika Ghale on 2023-07-15.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var EmailAddressTextField: UITextField!
    
    
    @IBOutlet weak var PasswordTextField: UITextField!
    let databaseManager = DatabaseManager()
    
    @IBAction func LoginButton(_ sender: UIButton) {
        
        guard let email = EmailAddressTextField.text,
                      let password = PasswordTextField.text else {
                    return
                }
        
        if let loggedInUser = databaseManager.loginUser(email: email, password: password) {
                    // Display user data or navigate to the next screen
                    // For example, you can show a welcome message in an alert
           
            
            
            
//            let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//            profileVC.loggedInuser = loggedInUser
            
            // Instantiate the tab bar controller from storyboard
            let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
            tabBarController.loggedInuser = loggedInUser
            self.navigationController?.pushViewController(tabBarController, animated: true)
            
            let userDefaults = UserDefaults.standard
            let encodedData = try? JSONEncoder().encode(loggedInUser)
            userDefaults.set(encodedData, forKey: "loggedInUser")
            
//            self.navigationController?.pushViewController(profileVC, animated: true)
            
            let message = "Welcome!"
            let alert = UIAlertController(title: "Login Successful", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
                   
                } else {
                    // Handle login failure, show an error message, etc.
                    let alert = UIAlertController(title: "Login Failed", message: "Invalid email or password", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    present(alert, animated: true, completion: nil)
                }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

