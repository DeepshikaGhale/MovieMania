//
//  Helper.swift
//  MovieMania
//
//  Created by Bikash Chhantyal on 2023-08-13.
//

import Foundation
import UIKit
import CoreData

struct UserModel: Codable{
    let fullName: String
    let email: String
    let password: String
    let username: String
    init(fullName: String, email: String, password: String, username: String) {
           self.fullName = fullName
           self.email = email
           self.username = username
        self.password = password
       }
}



class DatabaseManager{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Add user to coredata
    func addUser(_ user: UserModel){
        let userEntity = UserEntity(context: context)
        userEntity.fullName = user.fullName
        userEntity.email = user.email
        userEntity.password = user.password
        userEntity.username = user.username
        
        do{
            try context.save()
        }catch{
            print("User saving error", error)
        }
    }
    
    // Check if email exists
    func emailExists(email: String) -> Bool {
            let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            do {
                let results = try context.fetch(fetchRequest)
                return !results.isEmpty
            } catch {
                print("Error fetching data from Core Data", error)
                return false
            }
        }
    
    // Check if username exists
    func usernameExists(username: String) -> Bool {
            let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "username == %@", username)
    
            do {
                let results = try context.fetch(fetchRequest)
                return !results.isEmpty
            } catch {
                print("Error fetching data from Core Data:", error)
                return false
            }
        }
    
    
    func loginUser(email: String, password: String) -> UserModel? {
           let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "email == %@", email)
           
           do {
               let results = try context.fetch(fetchRequest)
               if let user = results.first, user.password == password {
                   let userModel = UserModel(
                       fullName: user.fullName ?? "",
                       email: user.email ?? "",
                       password: user.password ?? "",
                       username: user.username ?? ""
                   )
                   return userModel
               } else {
                   return nil
               }
           } catch {
               print("Error fetching data from Core Data:", error)
               return nil
           }
       }
    
}


