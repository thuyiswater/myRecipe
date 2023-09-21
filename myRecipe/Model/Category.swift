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

struct Category: Identifiable {
    var id: Int
    var name: (en: String, vi: String)
    var image: String
    
    static var categories: [Category] = [
        Category(id: 1, name: (en: "Breakfast", vi: "Bữa sáng"), image: "breakfast"),
        Category(id: 2, name: (en: "Lunch", vi: "Bữa trưa"), image: "lunch"),
        Category(id: 3, name: (en: "Dinner", vi: "Bữa tối"), image: "dinner"),
        Category(id: 4, name: (en: "Dessert", vi: "Tráng miệng"), image: "dessert"),
        Category(id: 5, name: (en: "Smoothies", vi: "Nước ép"), image: "smoothies")
    ]
}
