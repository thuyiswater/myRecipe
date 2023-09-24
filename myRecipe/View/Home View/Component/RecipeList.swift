//
//  SwiftUIView.swift
//  SignIn
//
//  Created by Gia Hân on 14/09/2023.
//

import SwiftUI

struct RecipeList: View {
    @Environment(\.presentationMode) var presentationMode
    var title: String
    @ObservedObject var recipeViewModel: RecipeViewModel
    @ObservedObject var userViewModel: UserViewModel
    @State private var minMakingTime: Int = 0
    @State private var maxMakingTime: Int = 1800
    @State private var category: String = "None"
    @Binding var viewedRecipes: [Recipe]
    @Binding var user: User
    var isRecipeMenu: Bool
    
    @State private var searchText: String = ""
    
    var filteredRecipes: [Recipe] {
        // Check if this view is displaying the user's viewed recipes.
        if (isRecipeMenu) {
            if searchText.isEmpty {
                // Filter viewed recipes based on making time and category criteria.
                let filtered = viewedRecipes.filter { recipe in
                    if let recipeTimeMaking = recipe.makingTime {
                        if (recipeTimeMaking <= maxMakingTime && recipeTimeMaking >= minMakingTime) {
                            if (category == "None") {
                                return true
                            } else if let recipeCategory = recipe.category {
                                return recipe.category == category
                            }
                        }
                    }
                    return false
                }
                return filtered
            } else {
                // Filter viewed recipes based on search text, making time, and category criteria.
                let filtered = viewedRecipes.filter { recipe in
                    if let recipeName = recipe.name {
                        if (recipeName.localizedCaseInsensitiveContains(searchText)) {
                            if let recipeTimeMaking = recipe.makingTime {
                                if (recipeTimeMaking <= maxMakingTime && recipeTimeMaking >= minMakingTime) {
                                    if (category == "None") {
                                        return true
                                    } else if let recipeCategory = recipe.category {
                                        return recipe.category == category
                                    }
                                }
                            }
                        }
                    }
                    return false
                }
                return filtered
            }
        } else if searchText.isEmpty {
            // Filter all recipes based on making time and category criteria.
            let filtered = recipeViewModel.recipes.filter { recipe in
                if let recipeTimeMaking = recipe.makingTime {
                    if (recipeTimeMaking <= maxMakingTime && recipeTimeMaking >= minMakingTime) {
                        if (category == "None") {
                            return true
                        } else if let recipeCategory = recipe.category {
                            return recipe.category == category
                        }
                    }
                }
                return false
            }
            return filtered
        } else {
            // Filter all recipes based on search text, making time, and category criteria.
            let filtered = recipeViewModel.recipes.filter { recipe in
                if let recipeName = recipe.name {
                    if (recipeName.localizedCaseInsensitiveContains(searchText)) {
                        if let recipeTimeMaking = recipe.makingTime {
                            if (recipeTimeMaking <= maxMakingTime && recipeTimeMaking >= minMakingTime) {
                                if (category == "None") {
                                    return true
                                } else if let recipeCategory = recipe.category {
                                    return recipe.category == category
                                }
                            }
                        }
                    }
                }
                return false
            }
            return filtered
        }
    }
    
    // These properties divide the filtered recipes into two columns for layout purposes.
    var leftColumnRecipes: [Recipe] {
            return filteredRecipes.enumerated().compactMap { (index, recipe) in
                return index % 2 == 0 ? recipe : nil
            }
        }
    
        var rightColumnRecipes: [Recipe] {
            return filteredRecipes.enumerated().compactMap { (index, recipe) in
                return index % 2 == 1 ? recipe : nil
            }
        }

        var body: some View {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack(spacing: 20){
                            BackButton
                                .padding(.leading, 15)
                            
                            SearchBar(text: $searchText, placeholder: "Search any recipes", minTimeMaking: $minMakingTime, maxTimeMaking: $maxMakingTime, category: $category)
                                    .frame(maxWidth: .infinity)
                                    .padding(.leading, 5)
                        }
                        .padding(.horizontal, 15)

                        HStack{
                            Text(title)
                                .font(.system(size: 26))
                                .bold()
                            Spacer()
                        }
                        .padding(.horizontal, 10)

                        HStack(alignment: .top, spacing: 5){
                            VStack(alignment: .leading){
                                Text(title)
                                    .font(.system(size: 20))
                                    .bold()
                                    .padding(.bottom, 20)
                                    .opacity(0)
                                
                                // Display each recipe in the left column with a navigation link to view its details.
                                ForEach(leftColumnRecipes) { recipe in
                                    NavigationLink(destination: RecipeInfo(recipe: recipe, recipeViewModel: recipeViewModel, userViewModel: userViewModel, viewedRecipes: $viewedRecipes, user: $user)) {
                                        GeneralRecipeView(recipe: recipe, userViewModel: userViewModel, size: 150.0)
                                    }
                                }
                            }
                            .frame(width: 180)
                            
                            VStack {
                                // Display each recipe in the right column with a navigation link to view its details.
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
                }
                .background(Color.gray.opacity(0.2))
            }
            .navigationBarBackButtonHidden(true)
        }
    
    // This button is used to dismiss the current view and navigate back to the previous one.
    var BackButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrow.left")
                .foregroundColor(Color("BackgroundColor"))
                .font(.title2)
                .background(Circle()
                                .fill(Color("ForegroundColor"))
                                .frame(width: 50, height: 50))
        })
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList(title: "", recipeViewModel: RecipeViewModel(),userViewModel: UserViewModel(), viewedRecipes: .constant([]), user: .constant(User(firstName: "", email: "", favourite: [])), isRecipeMenu: true)
    }
}
