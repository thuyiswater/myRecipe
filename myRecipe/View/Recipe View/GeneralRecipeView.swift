//
//  RecipeView.swift
//  SignIn
//
//  Created by Gia Hân on 08/09/2023.
//

import SwiftUI
import FirebaseStorage

struct GeneralRecipeView: View {
    var recipe: Recipe
    @ObservedObject var userViewModel: UserViewModel
    var size: CGFloat
    @State private var image: UIImage = UIImage()
    @State private var username: String = ""
    @State private var alignment = TextAlignment.leading
    
    var body: some View {
        VStack{
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .cornerRadius(20)
                .padding(.bottom, 10)
            
                Text(recipe.name ?? "")
                    .foregroundColor(Color("ForegroundColor"))
                    .bold()
                    .multilineTextAlignment(.leading)
                    .frame(width: 200)
            
            Text(" by \(username)")
                .frame(width: 200)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .onAppear{
            retrieveRecipeImage()
            username = recipe.getUserName(users: userViewModel.users)
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

struct GeneralRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralRecipeView(recipe: Recipe(
            name: Optional("Manchego and chorizo toasties"),
            image: Optional("images/960x1200-Cheats-Family-Ramen-13-copy-768x960.jpg"),
            makingTime: Optional(30),
            category: Optional("Dinner"),
            description: Optional("test"),
            ingredients: ["Chicken", "Pork"],
            instructions: ["prepare", "cook", "enjoy"],
            review: [],
            userDocumentID: "Ghngnj6XsqcNUhybGMdc",
            documentID: Optional("pKlpaclCOCElCisFuan6")), userViewModel: UserViewModel(), size: 200.0)
    }
}
