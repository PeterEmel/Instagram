//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Peter Emil on 10/07/2022.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private var database = Database.database().reference()
    
    //MARK: - Public
    
    /// Check if username and email are available
    public func canCreateNewUser(with email: String, username: String, completion: (Bool)-> Void) {
        completion(true)
    }
    
    public func insertNewUser(with email: String, username: String, password: String, completion: @escaping (Bool) -> Void) {
        let key = email.safeDatabaseKey()
        print("Key: \(key)")
        print("Username: \(username)")
        database.child(key).setValue(["Username": username]) { error, _ in
            if error == nil {
                completion(true)
                print("Succeded")
                return
            } else {
                completion(false)
                print("Err: \(error.debugDescription)")
                return
            }
        }
    }
    
    
}
