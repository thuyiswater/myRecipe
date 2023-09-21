/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Vi Phi Long
  ID: s3904632
  Created  date: 06/09/2023
  Last modified: 11/09/2023)
  Acknowledgement:
*/

import Foundation
import FirebaseFirestore
import FirebaseStorage

class UserViewModel: ObservableObject {
    @Published var users = [User]()
    private var db = Firestore.firestore()
    
    init() {
        getAllUserData()
    }
    
    func getAllUserData() {
        // Retrieve the "users" document
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // Loop to get the "name" field inside each user document
            self.users = documents.map { (queryDocumentSnapshot) -> User in
                let data = queryDocumentSnapshot.data()
                let firstName = data["firstName"] as? String ?? ""
                let lastName = data["lastName"] as? String ?? ""
                let dob = data["dob"] as? String ?? ""
                let gender = data["gender"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let phone = data["phone"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                let favourite = data["favourite"] as? [String] ?? []
                let avatar = data["avatar"] as? String ?? ""
                return User(firstName: firstName, lastName: lastName, dob: dob, gender: gender, email: email, phone: phone, address: address, favourite: favourite, avatar: avatar, documentID: queryDocumentSnapshot.documentID)
            }
        }
    }
    
    //function return a User model with matching email
    func getUserDataByEmail(email: String) -> User? {
        return self.users.first { user in
            user.email == email
        }
    }
    
    //register
    func addNewUserData(email: String) {
        // Add a new document to the "users" collection with the provided email and empty values for other attributes
        db.collection("users").addDocument(data: [
            "firstName": "",
            "lastName": "",
            "dob": "",
            "gender": "",
            "email": email, // Use the provided email
            "phone": "",
            "address": "",
            "favourite": [],
            "avatar": ""
        ])
    }
    
    func updateUserData(user: User) {
        // Ensure that the user has a valid document ID
        guard let documentID = user.documentID else {
            print("Invalid document ID")
            return
        }
        
        // Create a reference to the document in the "users" collection
        let userRef = db.collection("users").document(documentID)
        
        // Convert the user model to a dictionary
        let userDict: [String: Any] = [
            "firstName": user.firstName ?? "",
            "lastName": user.lastName ?? "",
            "dob": user.dob ?? "",
            "gender": user.gender ?? "",
            "email": user.email,
            "phone": user.phone ?? "",
            "address": user.address ?? "",
            "favourite": user.favourite,
            "avatar": user.avatar ?? ""
        ]
        
        // Update the document with the new data
        userRef.setData(userDict, merge: true) { error in
            if let error = error {
                print("Error updating user data: \(error.localizedDescription)")
            } 
        }
    }
    
    func uploadPhoto(selectedImage: UIImage?, completion: @escaping (String?) -> Void) {
        // Check if there is an image selected
        guard let selectedImage = selectedImage else {
            completion(nil)
            return
        }
        
        let storageRef = Storage.storage().reference()
        
        // Turn the image into data
        if let imageData = selectedImage.jpegData(compressionQuality: 0.9) {
            // Generate a unique path for the image
            let path = "images/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)
            
            // Upload the image
            fileRef.putData(imageData, metadata: nil) { metaData, error in
                // Check for errors during upload
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    completion(nil)
                } else {
                    // Upload successful, return the path
                    completion(path)
                }
            }
        } else {
            completion(nil)
        }
    }
}
