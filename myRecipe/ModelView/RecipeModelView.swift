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

class RecipeViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    private var db = Firestore.firestore()

    init() {
        getAllRecipeData()
    }

    func getAllRecipeData() {
        db.collection("recipes").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No recipe documents")
                return
            }

            // Create an array of recipes from documents
            let newRecipes = documents.compactMap { (queryDocumentSnapshot) -> Recipe? in
                let data = queryDocumentSnapshot.data()

                // Parse recipe data
                let name = data["name"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let makingTime = data["makingTime"] as? Int ?? 0
                let category = data["category"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let ingredients = data["ingredients"] as? [String] ?? []
                let instructions = data["instructions"] as? [String] ?? []
                let review = data["review"] as? [String] ?? []
                let userDocumentID = data["userDocumentID"] as? String ?? ""

                // Create a Recipe object
                return Recipe(
                    name: name,
                    image: image,
                    makingTime: makingTime,
                    category: category,
                    description: description,
                    ingredients: ingredients,
                    instructions: instructions,
                    review: review,
                    userDocumentID: userDocumentID,
                    documentID: queryDocumentSnapshot.documentID
                )
            }

            // Update the recipes array
            self.recipes = newRecipes
        }
    }
    
    func getRecipeByUser(user: User) -> [Recipe] {
        let userDocumentID = user.documentID
        
        // Filter the recipes array to include only recipes with matching userDocumentID
        let userRecipes = recipes.filter { $0.userDocumentID == userDocumentID }
        
        return userRecipes
    }

    
    // Function to add a new recipe
    func addNewRecipe(recipe: Recipe, completion: @escaping (Bool) -> Void) {
        db.collection("recipes").addDocument(data: [
            "name": recipe.name ?? "",
            "image": recipe.image ?? "",
            "makingTime": recipe.makingTime ?? 0,
            "category": recipe.category ?? "",
            "description": recipe.description ?? "",
            "ingredients": recipe.ingredients,
            "instructions": recipe.instructions,
            "review": recipe.review,
            "userDocumentID": recipe.userDocumentID
        ]) { (error) in
            if let error = error {
                // Handle the error and call the completion handler with `false`
                completion(false)
            } else {
                // Recipe added successfully, call the completion handler with `true`
                completion(true)
            }
        }
    }

    // Function to delete a recipe
    func deleteRecipe(recipe: Recipe, completion: @escaping (Result<String, Error>) -> Void) {
        guard let documentID = recipe.documentID else {
            completion(.failure("Invalid recipe document ID" as! Error))
            return
        }

        db.collection("recipes").document(documentID).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success("Recipe deleted successfully"))
            }
        }
    }

    // Function to update a recipe
    func updateRecipe(recipe: Recipe, completion: @escaping (Result<String, Error>) -> Void) {
        guard let documentID = recipe.documentID else {
            completion(.failure("Invalid recipe document ID" as! Error))
            return
        }

        let recipeRef = db.collection("recipes").document(documentID)

        let recipeData: [String: Any] = [
            "name": recipe.name ?? "",
            "image": recipe.image ?? "",
            "makingTime": recipe.makingTime ?? 0,
            "category": recipe.category ?? "",
            "description": recipe.description ?? "",
            "ingredients": recipe.ingredients,
            "instructions": recipe.instructions,
            "review": recipe.review,
            "userDocumentID": recipe.userDocumentID
        ]

        recipeRef.setData(recipeData, merge: true) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success("Recipe updated successfully"))
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

