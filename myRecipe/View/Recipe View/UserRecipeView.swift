//
//  RecipeView.swift
//  SignIn
//
//  Created by Gia Hân on 08/09/2023.
//

import SwiftUI
import FirebaseStorage

struct UserRecipeView: View {
    var recipe: Recipe
    @ObservedObject var userViewModel: UserViewModel
    var size: CGFloat
    @State private var image: UIImage = UIImage()
    @State private var username: String = ""
    
    var body: some View {
        HStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .cornerRadius(20)
                .padding(.bottom, 10)
            
            Text(recipe.name ?? "")
                .bold()
                .frame(maxWidth: size + 50)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .onAppear{
            retrieveRecipeImage()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
    
    func retrieveRecipeImage() {
        // Retrieve data
        let path = recipe.image ?? ""
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child(path)
        
        let maxSize: Int64 = Int64(5) * Int64(1024) * Int64(1024)
            
        fileRef.getData(maxSize: maxSize) { data, error in
            // Check for errors and data
            if error == nil, let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}

struct UserRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        UserRecipeView(recipe: Recipe(
            name: Optional("a very very and very long name"),
            image: Optional("images/733FDE59-865D-4ED5-B508-FD6EF186CF5B.jpg"),
            makingTime: Optional(30),
            category: Optional("Dinner"),
            description: Optional("test"),
            ingredients: ["Chicken", "Pork"],
            instructions: ["prepare", "cook", "enjoy"],
            review: [],
            userDocumentID: "Ghngnj6XsqcNUhybGMdc",
            documentID: Optional("pKlpaclCOCElCisFuan6")), userViewModel: UserViewModel(), size: 100.0)
    }
}
