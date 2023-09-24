//
//  BioAuthView.swift
//  SignIn
//
//  Created by mai chieu thuy on 16/09/2023.
//

import SwiftUI
import LocalAuthentication

struct BioAuthView: View {
    @State private var unlocked = false
    @State private var text = "LOCKED"
    var body: some View {
        VStack {
            Text(text)
                .bold()
                .padding()
            
            Button("Authenticate"){
                authenticate()
            }
        }
    }
    
    // Function to perform biometric authentication
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // Check if the device supports biometric authentication
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Attempt biometric authentication
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is security reason") { success, authenticationError in
                
                // Check if authentication was successful
                if success {
                    text = "UNCLOCKED"
                }
                else {
                    text = "There is a problem"
                }
            }
        }
        else {
            text = "Phone does not have bioauth"
        }
    }
}

struct BioAuthView_Previews: PreviewProvider {
    static var previews: some View {
        BioAuthView()
    }
}
