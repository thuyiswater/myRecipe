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

struct Recipe: Identifiable, Codable{
    // Unique identifier for the recipe
    var id: String = UUID().uuidString
    
    // Recipe properties
    var name: String?
    var image: String?
    var makingTime: Int?
    var category: String?
    var description: String?
    var ingredients: [String]
    var instructions: [String]
    var review: [String]
    var userDocumentID: String
    var documentID: String?
    
    // Method to retrieve the user's full name from a list of users
    func getUserName(users: [User]) -> String {
        if let user = users.first(where: { $0.documentID == self.userDocumentID }) {
            let firstName = user.firstName ?? ""
            let lastName = user.lastName ?? ""
            return firstName + " " + lastName
        }
        // Return a default message if the user is not found
        return "User not found"
    }

}
