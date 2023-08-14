//
//  Helper.swift
//  MovieMania
//
//  Created by Bikash Chhantyal on 2023-08-13.
//

import Foundation
import UIKit
import CoreData

struct UserModel{
    let fullName: String
    let email: String
    let password: String
    let username: String
}

class DatabaseManager{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
}


