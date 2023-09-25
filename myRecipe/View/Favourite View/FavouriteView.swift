//
//  FavouriteView.swift
//  SignIn
//
//  Created by Gia Hân on 08/09/2023.
//

import SwiftUI

struct FavouriteView: View {
    @Binding var user: User
    @ObservedObject var recipeViewModel: RecipeViewModel
    @ObservedObject var userViewModel: UserViewModel
    @Binding var viewedRecipes: [Recipe]
    @State private var favouritedRecipes: [Recipe] = []

    // Computed property to extract and display favourited recipes in the left column.
    var leftColumnRecipes: [Recipe] {
        return favouritedRecipes.enumerated().compactMap { (index, recipe) in
            return index % 2 == 0 ? recipe : nil
        }
    }
    
    // Computed property to extract and display favourited recipes in the right column.
    var rightColumnRecipes: [Recipe] {
        return favouritedRecipes.enumerated().compactMap { (index, recipe) in
            return index % 2 == 1 ? recipe : nil
        }
    }

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack{
                        Text("My Favourited Recipes")
                            .font(.system(size: 26))
                            .bold()
                            .padding(.bottom, 20)
                        Spacer()
                    }
                    .padding(.horizontal, 15)

                    HStack(alignment: .top, spacing: 5){
                        VStack(alignment: .leading){
                            Text("My Recipe")
                                .font(.system(size: 20))
                                .bold()
                                .padding(.bottom, 20)
                                .opacity(0)

                            // Display each favourited recipe in the left column with a navigation link to view its details.
                            ForEach(leftColumnRecipes) { recipe in
                                NavigationLink(destination: RecipeInfo(recipe: recipe, recipeViewModel: recipeViewModel, userViewModel: userViewModel, viewedRecipes: $viewedRecipes, user: $user)) {
                                    GeneralRecipeView(recipe: recipe, userViewModel: userViewModel, size: 150.0)
                                }
                            }
                        }
                        .frame(width: 180)

                        VStack {
                            // Display each favourited recipe in the right column with a navigation link to view its details.
                            ForEach(rightColumnRecipes) { recipe in
                                NavigationLink(destination: RecipeInfo(recipe: recipe, recipeViewModel: recipeViewModel, userViewModel: userViewModel, viewedRecipes: $viewedRecipes, user: $user)) {
                                    GeneralRecipeView(recipe: recipe, userViewModel: userViewModel, size: 150.0)
                                }
                            }
                        }
                        .frame(width: 180)
                    }
                    .padding(.top, 20)
                }
                .padding(.horizontal, 15)
            }
            .background(Color.gray.opacity(0.2))
            // Fetch favourited recipes based on user's favourites and store them in 'favouritedRecipes'.
            .onAppear {
                favouritedRecipes = recipeViewModel.recipes.filter { recipe in
                    if let recipeDocumentID = recipe.documentID {
                        return user.favourite.contains(recipeDocumentID)
                    }
                    return false
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView(user: .constant(User(firstName: "", email: "", favourite: [])), recipeViewModel: RecipeViewModel(), userViewModel: UserViewModel(), viewedRecipes: .constant([]))
    }
}
