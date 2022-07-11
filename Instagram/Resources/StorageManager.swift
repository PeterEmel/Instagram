//
//  StorageManager.swift
//  Instagram
//
//  Created by Peter Emil on 10/07/2022.
//

import FirebaseStorage
import Foundation

public class StorageManager {
    
    public enum UserPostType {
        case photo, Video
    }
    
    public struct UserPost {
        let postType: UserPostType
    }
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    //MARK: - Public
    
    public func uploadUserPost(model: UserPost, completeion: @escaping (Result<URL, Error>)->Void) {
        
    }
    
    public func downloadImage(with refrence: String, completion: @escaping (Result<URL, Error>) -> Void) {
        bucket.child(refrence).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(IGStorageManagerError.failedToDownload))
                return
            }
            
            completion(.success(url))
        }
    }
}
