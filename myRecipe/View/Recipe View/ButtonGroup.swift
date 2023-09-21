//
//  ButtonGroup.swift
//  SignIn
//
//  Created by Gia Hân on 17/09/2023.
//

import SwiftUI

struct ButtonGroup: View {
    @Environment(\.dismiss) var dismiss
    var recipe: Recipe
    @ObservedObject var recipeViewModel: RecipeViewModel
    @Binding var alertMessage: String
    @State private var isShowingAlert: Bool = false
    @State private var isEditing: Bool = false
    
    var body: some View {
        HStack(spacing: 35) {
            Button(action: {
                isEditing = true
            }, label: {
                Image(systemName: "pencil.tip")
                    .foregroundColor(Color("BackgroundColor"))
                    .font(.title2)
                    .background(Circle()
                            .fill(Color("PrimaryColor"))
                            .frame(width: 50, height: 50))
            })
            .background{
                NavigationLink("", destination: UpdateRecipeView(recipe: recipe, recipeViewModel: recipeViewModel), isActive: $isEditing)
            }
            
            Button(action: {
                isShowingAlert = true
            }, label: {
                Image(systemName: "trash")
                    .foregroundColor(Color("BackgroundColor"))
                    .font(.title2)
                    .background(Circle()
                        .fill(.red)
                        .frame(width: 50, height: 50))
            })
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("Are you sure you want to delete this recipe?"),
                    primaryButton: .cancel(),
                    secondaryButton: .default(
                        Text("Yes"),
                        action: {
                            recipeViewModel.deleteRecipe(recipe: recipe) { result in
                                switch result {
                                case .success(let message):
                                    alertMessage = message
                                case .failure(let error):
                                    alertMessage = "Error deleting recipe: \(error.localizedDescription)"
                                }
                            }
                            dismiss()
                        }
                    )
                )
            }
        }
    }
}


struct ButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        ButtonGroup(recipe: Recipe(ingredients: [], instructions: [], review: [], userDocumentID: ""),recipeViewModel: RecipeViewModel(), alertMessage: .constant(""))
    }
}
