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

struct Ingredient: Identifiable {
    var id: Int
    var name: (en: String, vi: String)
    var image: String
    
    static var ingredients: [Ingredient] = [
        Ingredient(id: 1, name: (en: "Chicken", vi: "Thịt Gà"), image: "chicken"),
        Ingredient(id: 2, name: (en: "Pork", vi: "Thịt Heo"), image: "pork"),
        Ingredient(id: 3, name: (en: "Beef", vi: "Thịt Bò"), image: "beef")
    ]
}

