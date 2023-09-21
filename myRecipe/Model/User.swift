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

struct User: Codable, Identifiable {
    var id: String = UUID().uuidString
    var firstName: String?
    var lastName: String?
    var dob: String?
    var gender: String?
    var email: String
    var phone: String?
    var address: String?
    var favourite: [String] //documentID of Recipes 
    var avatar: String?
    var documentID: String?
}

