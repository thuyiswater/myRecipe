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

import SwiftUI

struct HomeView: View {
    @Binding var user: User
    @ObservedObject var recipeViewModel: RecipeViewModel
    @ObservedObject var userViewModel: UserViewModel
    @State private var isShowingRecommendationList: Bool = false
    @State private var isShowingROTWList: Bool = false
    @State private var recommendationRecipes: [Recipe] = []
    @State private var recipesOfTheWeek: [Recipe] = []
    @State private var newestRecipes: [Recipe] = []
    @Binding var viewedRecipes: [Recipe]
    @Binding var recipesByCategory: [[Recipe]]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack {
                        //MARK: Slogan
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Hello \(user.firstName ?? "")")
                                
                                Spacer()
                            }
                            
                            Text("What would you like \nto cook today?")
                                .font(.system(size: 32))
                                .bold()
                        }
                        .padding(.leading, 5)
                        
                        VStack(spacing: 40) {
                            //MARK: Search bar
//                            SearchBar()
                            
                            VStack {
                                //MARK: Categories
                                HStack {
                                    Text("Categories")
                                        .font(.system(size: 24))
                                        .bold()
                                    
                                    Spacer()
                                }
                                .padding(.top, 30)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 15) {
                                        ForEach(Category.categories.indices) { i in
                                            NavigationLink {
                                                RecipeList(title: "Recipe for \(Category.categories[i].name.en)", recipeViewModel: recipeViewModel, userViewModel: userViewModel, viewedRecipes: $recipesByCategory[i], user: $user, isRecipeMenu: true)
                                            } label: {
                                                CategoryButton(category: Category.categories[i], width: 100)
                                            }.buttonStyle(.plain)
                                        }
                                    }
                                    .padding(.leading, 1)
                                    .padding(.vertical, 2)
                                }
                            }
                            
                            //MARK: Recipes of the week
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Newest")
                                        .font(.system(size: 24))
                                        .bold()
                                    
                                    Spacer()
                                    
                                    Button {
                                        isShowingROTWList = true
                                    } label: {
                                        Text("See all")
                                            .foregroundColor(Color("PrimaryColor"))
                                            .bold()
                                    }
                                    .background{
                                        NavigationLink("", destination: RecipeList(title: "Recipe of The Week", recipeViewModel: recipeViewModel, userViewModel: userViewModel, viewedRecipes: $viewedRecipes, user: $user, isRecipeMenu: false), isActive: $isShowingROTWList)
                                    }
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack{
                                        ForEach(newestRecipes) {recipe in
                                            NavigationLink(destination: RecipeInfo(recipe: recipe, recipeViewModel: recipeViewModel, userViewModel: userViewModel, viewedRecipes: $viewedRecipes, user: $user)) {
                                                GeneralRecipeView(recipe: recipe, userViewModel: userViewModel, size: 200.0)
                                            }
                                        }
                                    }
                                }
                            }
                            
                            //MARK: Recommendation
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Recommendation")
                                        .font(.system(size: 24))
                                        .bold()
                                    
                                    Spacer()
                                    
                                    Button {
                                        isShowingRecommendationList = true
                                    } label: {
                                        Text("See all")
                                            .foregroundColor(Color("PrimaryColor"))
                                            .bold()
                                    }
                                    .background{
                                        NavigationLink("", destination: RecipeList(title: "Recommendation", recipeViewModel: recipeViewModel, userViewModel: userViewModel, viewedRecipes: $viewedRecipes, user: $user, isRecipeMenu: false), isActive: $isShowingRecommendationList)
                                    }
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack{
                                        ForEach(recommendationRecipes) {recipe in
                                            NavigationLink(destination: RecipeInfo(recipe: recipe, recipeViewModel: recipeViewModel, userViewModel: userViewModel, viewedRecipes: $viewedRecipes, user: $user)) {
                                                GeneralRecipeView(recipe: recipe, userViewModel: userViewModel, size: 200.0)
                                            }
                                        }
                                    }
                                }
                            }
                            
                            //MARK: Recipes of the week
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Recipes Of The Week")
                                        .font(.system(size: 24))
                                        .bold()
                                    
                                    Spacer()
                                    
                                    Button {
                                        isShowingROTWList = true
                                    } label: {
                                        Text("See all")
                                            .foregroundColor(Color("PrimaryColor"))
                                            .bold()
                                    }
                                    .background{
                                        NavigationLink("", destination: RecipeList( title: "Recipe of The Week", recipeViewModel: recipeViewModel, userViewModel: userViewModel, viewedRecipes: $viewedRecipes, user: $user, isRecipeMenu: false), isActive: $isShowingROTWList)
                                    }
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack{
                                        ForEach(recipesOfTheWeek) {recipe in
                                            NavigationLink(destination: RecipeInfo(recipe: recipe, recipeViewModel: recipeViewModel, userViewModel: userViewModel, viewedRecipes: $viewedRecipes, user: $user)) {
                                                GeneralRecipeView(recipe: recipe, userViewModel: userViewModel, size: 200.0)
                                            }
                                        }
                                    }
                                }
                            }
                            
                            //MARK: Recently Viewed
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Recently Viewed")
                                        .font(.system(size: 24))
                                        .bold()
                                    
                                    Spacer()
                                    
                                    Button {
                                        isShowingRecommendationList = true
                                    } label: {
                                        Text("See all")
                                            .foregroundColor(Color("PrimaryColor"))
                                            .bold()
                                    }
                                    .background{
                                        NavigationLink("", destination: RecipeList(title: "Recommendation", recipeViewModel: recipeViewModel, userViewModel: userViewModel, viewedRecipes: $viewedRecipes, user: $user, isRecipeMenu: false), isActive: $isShowingRecommendationList)
                                    }
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack{
                                        ForEach(viewedRecipes) {recipe in
                                            NavigationLink(destination: RecipeInfo(recipe: recipe, recipeViewModel: recipeViewModel, userViewModel: userViewModel, viewedRecipes: $viewedRecipes, user: $user)) {
                                                GeneralRecipeView(recipe: recipe, userViewModel: userViewModel, size: 200.0)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
                .padding(.bottom, 30)
            }
            .background(Color.gray.opacity(0.2))
            .onAppear{
                for i in 0..<Category.categories.count {
                    recipesByCategory[i] = recipeViewModel.recipes.filter { recipe in
                        if let recipeCategory = recipe.category {
                            return recipeCategory == Category.categories[i].name.en
                        }
                        return false
                    }
                }

                //get the newest ones
                newestRecipes = Array(recipeViewModel.recipes.suffix(10))

                // Randomly select 10 more recipes for recommendations
                var remainingRecipes = Array(recipeViewModel.recipes.dropLast(10))
                recommendationRecipes = Array(recipeViewModel.recipes.shuffled().prefix(10))

                // Set recipesOfTheWeek to a subset of allRecipes (you can adjust this logic as needed)
                recipesOfTheWeek = Array(recipeViewModel.recipes.prefix(10))
                print(recipeViewModel.recipes)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(user: .constant(User(
            firstName: "",
            lastName: "",
            dob: "",
            gender: "",
            email: "",
            phone: "",
            address: "",
            favourite: [],
            avatar: "",
            documentID: ""
        )),
                 recipeViewModel: RecipeViewModel(),
                 userViewModel: UserViewModel(),
                 viewedRecipes: .constant([])
                 , recipesByCategory: .constant([]))
    }
}
