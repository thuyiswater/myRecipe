//
//  MyRecipeView.swift
//  SignIn
//
//  Created by Gia Hân on 11/09/2023.
//

import SwiftUI

 

struct MyRecipeView: View {
    var user: User
    @ObservedObject var recipeViewModel: RecipeViewModel
    @ObservedObject var userViewModel: UserViewModel
    @State private var alertMessage: String = ""
    @State private var isShowingAlert: Bool = false

    var leftColumnRecipes: [Recipe] {
        return recipeViewModel.getRecipeByUser(user: user).enumerated().compactMap { (index, recipe) in
            return index % 2 == 0 ? recipe : nil
        }
    }

    var rightColumnRecipes: [Recipe] {
        return recipeViewModel.getRecipeByUser(user: user).enumerated().compactMap { (index, recipe) in
            return index % 2 == 1 ? recipe : nil
        }
    }

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack{
                        Text("My Recipe")
                            .font(.system(size: 26))
                            .bold()

                        Spacer()
                    }
                    .padding(.horizontal, 15)

                    HStack(alignment: .top, spacing: 5){
                        VStack(alignment: .leading){
                            Text("My Recipe")
                                .padding(.bottom, 20)
                                .opacity(0)
                            
                            ForEach(leftColumnRecipes) { recipe in
                                NavigationLink(destination: MyRecipeInfo(recipe: recipe, recipeViewModel: recipeViewModel, alertMessage: $alertMessage)) {

                                    GeneralRecipeView(recipe: recipe, userViewModel: userViewModel, size: 150.0)
                                }
                            }
                        }
                        .frame(width: 180)

                        VStack {
                            ForEach(rightColumnRecipes) { recipe in
                                NavigationLink(destination: MyRecipeInfo(recipe: recipe, recipeViewModel: recipeViewModel, alertMessage: $alertMessage)) {
                                    GeneralRecipeView(recipe: recipe, userViewModel: userViewModel, size: 150.0)
                                }
                            }
                        }
                        .frame(width: 180)
                    }
                }
                .padding(.horizontal, 15)
            }
            .background(Color.gray.opacity(0.2))
            // Handle alert presentation when alertMessage changes.
            .onChange(of: alertMessage) { newValue in
                if newValue != "" {
                    isShowingAlert = true
                }
            }
            
            // Present an alert when isShowingAlert is true.
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("Delete Recipe"),
                    message: Text(alertMessage)
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

 

struct MyRecipeView_Previews: PreviewProvider {

    static var previews: some View {

        MyRecipeView(user: User(firstName: "", email: "", favourite: []), recipeViewModel: RecipeViewModel(),userViewModel: UserViewModel())

    }

}
