//
//  UpdateRecipeView.swift
//  SignIn
//
//  Created by Gia Hân on 19/09/2023.
//

import SwiftUI

struct UpdateRecipeView: View {
    @Environment(\.dismiss) var dismiss
    var recipe: Recipe
    @ObservedObject var recipeViewModel: RecipeViewModel
    @State private var alertMessage: String = ""
    
    let catergoryArr: [String] = ["None", "Breakfast", "Lunch", "Dinner", "Dessert", "Smoothies"]
    
    @State private var recipeName: String = ""
    @State private var description: String = ""
    @State private var category: String = "None"
    @State private var makingTime: Int = 0
    @State private var ingredients: [String] = [""]
    @State private var instructions: [String] = [""]
    @State private var isShowingSuccess: Bool = false
    @State private var isUpdatingRecipe: Bool = false
    
    var body: some View {
        ZStack {
            VStack{
                // Header with title and close button.
                HStack {
                    Button {
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 28))
                            .bold()
                            .opacity(0)
                    }

                    Spacer()

                    Text("Update Recipe")
                        .font(.system(size: 32))
                        .padding(.top, 20)

                    Spacer()

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 28))
                            .foregroundColor(Color("ForegroundColor"))
                            .bold()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom,20)
                
                ScrollView(.vertical, showsIndicators: false) {
                    // Form fields for updating recipe details.
                    VStack(spacing: 15){
                        VStack(alignment: .leading, spacing: 10){
                            Text("Recipe Name")
                                .font(.system(size: 20))
                                .foregroundColor(.secondary)
                            
                            TextField("Recipe Name", text: $recipeName)
                                .padding()
                                .background(.thinMaterial)
                                .cornerRadius(10)
                                .textInputAutocapitalization(.never)
                        }
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("Short Description")
                                .font(.system(size: 20))
                                .foregroundColor(.secondary)
                            
                            TextField("Short Description", text: $description)
                                .padding()
                                .background(.thinMaterial)
                                .cornerRadius(10)
                                .textInputAutocapitalization(.never)
                        }
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("Category")
                                .font(.system(size: 20))
                                .foregroundColor(.secondary)
                            
                            SelectButton(array: catergoryArr, selection: $category)
                        }
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("Making Time")
                                .font(.system(size: 20))
                                .foregroundColor(.secondary)
                            
                            TimePicker(makingTime: $makingTime)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Ingredients")
                                    .font(.system(size: 20))
                                    .foregroundColor(.secondary)
                                
                                Spacer()
                                
                                Button {
                                    ingredients.append("")
                                } label: {
                                    Image(systemName: "plus")
                                        .foregroundColor(Color("ForegroundColor"))
                                        .font(.system(size: 20))
                                }
                            }
                            
                            VStack(spacing: 2) {
                                ForEach(ingredients.indices, id: \.self) { index in
                                    HStack {
                                        TextField("Ingredient", text: $ingredients[index])
                                        
                                        Button {
                                            ingredients.remove(at: index)
                                        } label: {
                                            Text("X")
                                                .bold()
                                                .padding()
                                                .foregroundColor(.red)
                                                .background(.thinMaterial)
                                                .cornerRadius(10)
                                        }
                                    }
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Intructions")
                                    .font(.system(size: 20))
                                    .foregroundColor(.secondary)
                                
                                Spacer()
                                
                                Button {
                                    instructions.append("")
                                } label: {
                                    Image(systemName: "plus")
                                        .foregroundColor(Color("ForegroundColor"))
                                        .font(.system(size: 20))
                                }
                            }
                            
                            VStack(spacing: 2) {
                                ForEach(instructions.indices, id: \.self) { index in
                                    HStack{
                                        Text("Step \(index+1)")
                                        
                                        TextField("Instruction", text: $instructions[index])
                                            .padding()
                                            .background(.thinMaterial)
                                            .cornerRadius(10)
                                            .textInputAutocapitalization(.never)
                                        
                                        Button {
                                            instructions.remove(at: index)
                                        } label: {
                                            Text("X")
                                                .bold()
                                                .padding()
                                                .foregroundColor(.red)
                                                .background(.thinMaterial)
                                                .cornerRadius(10)
                                        }
                                    }
                                }
                            }
                        }
                        
                        Button {
                            handleUpdateButton()
                        } label: {
                            Text("Update")
                                .bold()
                                .foregroundColor(Color.white)
                                .frame(width: 300, height: 50)
                                .background(Color("PrimaryColor"))
                                .cornerRadius(10)
                                .padding(.bottom, 30)
                        }
                        .padding(.top, 25)

                    }
                    .padding()
                }
                
                Spacer()
            }
            .alert(isPresented: $isShowingSuccess) {
                Alert(
                    title: Text("Update Recipe"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        dismiss()
                    }
                )
            }
            // Initialize form fields with the existing recipe data.
            .onAppear{
                recipeName = recipe.name ?? ""
                description = recipe.description ?? ""
                category = recipe.category ?? "None"
                makingTime = recipe.makingTime ?? 0
                ingredients = recipe.ingredients
                instructions = recipe.instructions
            }
            
            if isUpdatingRecipe {
                LoadingScreen() // Display loading screen
            }
        }
        .background(Color.gray.opacity(0.2))
        .navigationBarBackButtonHidden(true)
    }
    
    func handleUpdateButton() {
        isUpdatingRecipe = true

        // Update the properties of the existing recipe        
        let updatedRecipe = Recipe(
            name: recipeName,
            image: recipe.image,
            makingTime: makingTime,
            category: category,
            description: description,
            ingredients: ingredients,
            instructions: instructions,
            review: [],
            userDocumentID: recipe.userDocumentID,
            documentID: recipe.documentID
        )

        // Pass the updated recipe to the view model's updateRecipe function
        recipeViewModel.updateRecipe(recipe: updatedRecipe) { result in
            isUpdatingRecipe = false

            switch result {
            case .success(let message):
                isShowingSuccess = true
                alertMessage = message

            case .failure(let error):
                // Handle the error and show an alert with an error message
                alertMessage = "Error updating recipe: \(error.localizedDescription)"
            }
        }
    }
}

struct UpdateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRecipeView(recipe: Recipe(id: "9C4438DB-F970-4DB5-A2D4-41628CA67F0B", name: Optional("Air fryer chicken breast salad"), image: Optional("images/2022D512_AIRFRYER_SALAD-768x960.jpg"), makingTime: Optional(20), category: Optional("Dinner"), description: Optional("Chicken is an air fryer’s best friend – it cooks it quickly, evenly and without drying it out. This simple recipe for spiced chicken breast is served with a honey mustard salad, but you can cook the breasts and serve them however you like."), ingredients: ["2 skinless free-range chicken breasts", "Juice 1 lemon", "1 tbsp olive oil", "1 tbsp smoked paprika", "1 tsp sea salt", "1 tsp freshly ground black pepper", "1 tsp cayenne pepper", "½ tsp dried oregano"], instructions: ["Put each chicken breast between 2 sheets of baking paper and bash with a rolling pin until evenly flat all over (they don’t have to be super-thin, just the same thickness throughout). Use a fork to prick lots of little holes in the chicken, then put them in a dish and coat with the lemon juice and olive oil.", "Heat the air fryer to 190°C. Mix the paprika, salt, pepper, cayenne and oregano together, then massage the mixture all over the chicken breasts, ensuring an even, liberal coverage. Put the chicken in the air fryer and cook for 16 minutes, turning halfway.", "While the chicken cooks, put the honey, mustard, oil, vinegar and garlic in a clean jam jar, season with a generous pinch of salt and pepper and shake to create a dressing. Season the tomatoes with a pinch of salt.", "To serve, toss the lettuce in some of the dressing to coat, then divide between bowls. Arrange the tomatoes and capers on top. Slice the chicken breasts and put them in the centre, then drizzle over the remaining dressing."], review: [], userDocumentID: "L56IcwjgJP1mKaN4wdI3", documentID: Optional("wYMAnwGqv0zGhmOFyEul")), recipeViewModel: RecipeViewModel())
    }
}
