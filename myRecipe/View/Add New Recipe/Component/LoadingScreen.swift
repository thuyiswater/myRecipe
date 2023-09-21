//
//  LoadingScreen.swift
//  SignIn
//
//  Created by Gia Hân on 17/09/2023.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color("PrimaryColor")))
                        .scaleEffect(3.0) // Increase the scale for a larger spinner
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .background(Color.gray.opacity(0.4))
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}

