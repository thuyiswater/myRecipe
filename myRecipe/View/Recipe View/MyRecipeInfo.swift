//
//  MyRecipeInfo.swift
//  SignIn
//
//  Created by Gia Hân on 19/09/2023.
//

import SwiftUI
import FirebaseStorage

struct MyRecipeInfo: View {
    @Environment(\.presentationMode) var presentationMode
    var recipe: Recipe
    @ObservedObject var recipeViewModel: RecipeViewModel
    @Binding var alertMessage: String
    @State private var image: UIImage = UIImage()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20){
                ZStack{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .frame(maxWidth: .infinity, minHeight: 160)
                    
                    VStack {
                        HStack{
                            BackButton
                            
                            Spacer()
                            
                            ButtonGroup(recipe: recipe, recipeViewModel: recipeViewModel, alertMessage: $alertMessage)
                        }
                        .padding(.top, 30)
                        .padding(.horizontal, 20)
                        
                        Spacer()
                    }
                }
                
                ZStack {
                    VStack(alignment: .leading, spacing: 30){
                        VStack(alignment: .leading){
                            Text(recipe.name ?? "")
                                .font(.system(size: 22))
                                .bold()
                                .multilineTextAlignment(.center)
                            
                            HStack(spacing: 30){
                                HStack(spacing: 10){
                                    Image(systemName: "fork.knife.circle")
                                    
                                    Text(recipe.category ?? "")
                                }
                                
                                HStack(spacing: 10){
                                    Image(systemName: "clock")
                                    
                                    Text("\(recipe.makingTime ?? 0)")
                                }
                            }
                            .font(.system(size: 18))
                            .foregroundColor(.secondary)
                        }
                        .padding(.top, 40)
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("Description")
                                .font(.system(size: 20))
                                .bold()
                            
                            Text(recipe.description ?? "")
                                .foregroundColor(.secondary)
                        }
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("Ingredients")
                                .font(.system(size: 20))
                                .bold()
                            
                            ForEach(recipe.ingredients, id:\.self) {ingredient in
                                Text(ingredient)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("Instructions")
                                .font(.system(size: 20))
                                .bold()
                            
                            ForEach(recipe.instructions, id:\.self) {instruction in
                                Text(instruction)
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(20)
                }
                
            }
            .padding(.top, 60)
            .padding(.bottom, 20)
            .padding(.horizontal, 15)
            .background(Color.gray.opacity(0.2))
            .onAppear{
                retrieveRecipeImage()
            }
        }
        .ignoresSafeArea()
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
    
    var BackButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrow.left")
                .foregroundColor(Color("ForegroundColor"))
                .font(.title2)
                .background(Circle()
                        .fill(.thinMaterial)
                        .frame(width: 50, height: 50))
        })
    }
}

struct MyRecipeInfo_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipeInfo(recipe: Recipe(id: "", name: Optional("Charred chicken ramen bowls"), image: Optional("images/960x1200-Cheats-Family-Ramen-13-copy-768x960.jpg"), makingTime: Optional(30), category: Optional("Breakfast"), description: Optional("These quick chicken ramen bowls by Donal Skehan are by no means traditional but with their full flavours and soul-soothing properties, they come close!"), ingredients: ["4 free-range skinless, boneless chicken thighs", "50ml low sodium soy sauce", "50ml mirin (Japanese rice wine, from supermarkets)", "300g pack ramen noodles", "100g fresh beansprouts", "4 medium free-range eggs, soft boiled and halved", "Handful fresh coriander leaves", "Handful fresh mint leaves", "1 garlic clove, thinly sliced", "1 thumb-size piece fresh ginger, thinly sliced 1.5 litres best quality chicken stock", "2 large carrots, julienned (cut into matchsticks)", "100g shiitake mushrooms, halved if large", "1 tsp sesame oil"], instructions: ["Put the chicken, soy sauce, mirin and sesame oil in a bowl and set aside to marinate.", "For the broth, put the chilli, garlic, ginger and stock in a large saucepan. Simmer over a medium heat and cook for 15 minutes, then strain and return the liquid to the pan (discard the solids). Add the carrots and mushrooms and cook for another 5 minutes until softened. Season to taste with salt and sesame oil.", "Before the end of the cooking time, blanch the broccoli in the broth for 2-3 minutes until tender, then remove with a slotted spoon and set aside. While the broth simmers, cook the noodles according to the pack instructions, then drain and set aside.", "To cook the chicken, heat a griddle pan or frying pan over a high heat. Remove the chicken from the marinade and cook for 4 minutes on each side or until cooked all the way through and the chicken has deep char marks. Remove from the heat and slice.", "Arrange the noodles in bowls with the broccoli, chicken slices, beansprouts, spring onions and soft boiled eggs. Ladle over the hot broth with the carrots and mushrooms, then serve straightaway garnished with fresh coriander and mint"], review: [], userDocumentID: "WLhbC4pUvrd2B3021cq9mxffhcW2",documentID: Optional("2mTPS6Bs3psVy4BoOcbE")),
                     recipeViewModel: RecipeViewModel(),
                     alertMessage: .constant(""))
    }
}
