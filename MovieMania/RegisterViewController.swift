//
//  RegisterViewController.swift
//  MovieMania
//
//  Created by Deepshika Ghale on 2023-07-23.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var FullNameTextField: UITextField!
    
    @IBOutlet weak var EmailAddressTextField: UITextField!
    
    @IBOutlet weak var UsernameTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    private let manager = DatabaseManager()
    
    @IBAction func RegisterButton(_ sender: Any) {
     
        guard let fullName = FullNameTextField.text, !fullName.isEmpty else{
            openAlert(message: "Please enter your full name.")
            return
        }
        
        guard isValidFullName(fullName) else {
            openAlert(message: "Please enter a valid full name (letters and spaces only).")
                    return
                }
        
        guard let email = EmailAddressTextField.text, !email.isEmpty else {
            openAlert(message: "Please enter your email address.")
                    return
                }
                
        guard isValidEmail(email) else {
            openAlert(message: "Please enter a valid email address.")
                    return
                }
        
        guard let username = UsernameTextField.text, !username.isEmpty else{
            openAlert(message: "Please enter a username.")
            return
        }
        
        guard isValidUsername(username) else {
            openAlert(message: "Please enter a valid username (alphanumeric characters only).")
                    return
                }
        
        guard let password = PasswordTextField.text, !password.isEmpty else {
            openAlert(message: "Please enter a password.")
            return
        }
        
        guard isValidPassword(password) else {
            openAlert(message: "Password should be at least 6 characters long and contain at least one uppercase letter, one lowercase letter, and one digit.")
            return
        }
    
        let registeredUser = UserModel(
            fullName: fullName,
            email: email,
            password: password,
            username: username
        )
       
        if manager.emailExists(email: email){
            openAlert(message: "Sorry! Email already registerd.")
        } else if manager.usernameExists(username: username){
            openAlert(message: "Sorry! Username already take. Choose anaother one.")
        }else{
            manager.addUser(registeredUser)
            performSegue(withIdentifier: "UserProfile", sender: registeredUser)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

//    func openAlert(message: String){
//        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(okAction)
//        present(alertController, animated: true, completion: nil)
//    }
    
    private func openAlert(message: String) {
            DispatchQueue.main.async {
                let attributedMessage = NSAttributedString(string: message, attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.red
                ])
                
                let alertController = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
                alertController.setValue(attributedMessage, forKey: "attributedMessage")
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    
    // Helper method to validate full name format and length
        func isValidFullName(_ fullName: String) -> Bool {
            let fullNameRegex = "^[a-zA-Z]+( [a-zA-Z]+)*$"
            return NSPredicate(format: "SELF MATCHES %@", fullNameRegex).evaluate(with: fullName) && fullName.count >= 5 && fullName.count <= 50
        }
    
    // Helper method to validate email format
        func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
        }
    
    // Helper method to validate password format
       func isValidPassword(_ password: String) -> Bool {
           let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{6,}$"
           return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
       }
        
       
            
            // Helper method to validate username format and length
            func isValidUsername(_ username: String) -> Bool {
                let usernameRegex = "^[a-zA-Z0-9]+$"
                return NSPredicate(format: "SELF MATCHES %@", usernameRegex).evaluate(with: username) && username.count >= 5 && username.count <= 20
            }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
