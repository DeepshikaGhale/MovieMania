//
//  TabViewController.swift
//  MovieMania
//
//  Created by Bikash Chhantyal on 2023-08-15.
//

import UIKit

class TabViewController: UITabBarController {

    var loggedInuser: UserModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide the back button
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.title = "MovieMania" //set the title
        
        // Retrieve logged-in user data from UserDefaults
        let userDefaults = UserDefaults.standard
        if let encodedData = userDefaults.data(forKey: "loggedInUser"),
        let loggedInUser = try? JSONDecoder().decode(UserModel.self, from: encodedData) {
                    self.loggedInuser = loggedInUser
            }
    }
    
    @objc func profileButtonTapped(){
        
    }
    
    func logout() {
            // Remove user data from UserDefaults
            UserDefaults.standard.removeObject(forKey: "loggedInUser")
            // Navigate back to the login screen
            if let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                navigationController?.setViewControllers([loginViewController], animated: true)
            }
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
