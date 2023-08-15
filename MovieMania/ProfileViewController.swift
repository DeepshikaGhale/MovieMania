//
//  ProfileViewController.swift
//  MovieMania
//
//  Created by Bikash Chhantyal on 2023-08-14.
//

import UIKit

class ProfileViewController: UIViewController {
//    var loggedInuser: UserModel?
    
    @IBOutlet weak var UsernameTextField: UILabel!
    
    @IBOutlet weak var NameTextField: UILabel!
    
    @IBOutlet weak var EmailTextField: UILabel!
    
    
  
    @IBAction func LoginBtnTapped(_ sender: Any) {
        
        if let tabBarController = self.tabBarController as? TabViewController{
            tabBarController.logout()
        }
        
    }
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        if let user = (self.tabBarController as? TabViewController)?.loggedInuser{
            UsernameTextField.text = "@\(String(describing: user.username))"
            EmailTextField.text = user.email
            NameTextField.text = user.fullName
        }
        
        // Do any additional setup after loading the view.
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
