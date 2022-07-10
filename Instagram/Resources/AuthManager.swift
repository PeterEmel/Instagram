//
//  AuthManager.swift
//  Instagram
//
//  Created by Peter Emil on 10/07/2022.
//

import FirebaseAuth
import UIKit

public class AuthManager {
    
    static let shared = AuthManager()
    
    //MARK: - Public
    
    public func registerNewUser(username: String, email:String, password: String, completion: @escaping(Bool)-> Void) {
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    // Firebase auth could not create account
                    guard error == nil, result != nil else {
                        completion(false)
                        print("Register Error: \(error.debugDescription)")
                        return
                    }
                    // insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username, password: password) { inserted in
                        if inserted {
                            print("inserted")
                            completion(true)
                            return
                        } else {
                            print("not inserted")
                            completion(false)
                            return
                        }
                    }
                    
                }
                
            } else {
                // either username or email does not exit
                print("Can't Create")
                completion(false)
            }
            
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping(Bool)->Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = username{
            print(username)
        }
        
    }

    
}
