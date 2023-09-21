//
//  myRecipeApp.swift
//  myRecipe
//
//  Created by mai chieu thuy on 21/09/2023.
//

import SwiftUI
import Firebase

@main
struct myRecipeApp: App {
    //@AppStorage("isDarkMode") private var isDarkMode = false
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            LandingView()
                //.preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
