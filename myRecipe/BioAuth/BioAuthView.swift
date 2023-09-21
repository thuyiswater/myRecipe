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
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is security reason") { success, authenticationError in
                
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
