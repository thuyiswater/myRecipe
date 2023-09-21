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
import Firebase

struct SignUpView: View {
    var userViewModel: UserViewModel
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    @State var signUpSuccess = false
    @State private var isShowingSignInView: Bool = false
    @State private var alert: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Spacer()
                
                Text("Sign Up")
                    .font(.system(size: 40))
                    .bold()
                
                Text(alert)
                    .foregroundColor(signUpSuccess ? Color("PrimaryColor") : .red)
                
                Group {
                    TextField("Email", text: $email)
                        .padding()
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                        .onTapGesture {
                            // Clear the alert when the Password TextField is tapped
                            alert = ""
                        }
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .onTapGesture {
                            // Clear the alert when the Password TextField is tapped
                            alert = ""
                        }
                    
                    SecureField("Confirm Password", text: $passwordConfirmation)
                        .padding()
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .border(Color.red, width: passwordConfirmation != password ? 1 : 0)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            // Clear the alert when the Password TextField is tapped
                            alert = ""
                        }
                }
                .padding(.horizontal, 10)
                
                // Sign up button
                Button(action: {
                    signUp()
                }) {
                    Text("Sign Up")
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 300, height: 50)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(10)
                        .padding(.bottom, 30)
                }
                
                HStack{
                    Text("Already have an account?")
                    NavigationLink(destination: SignInView(userViewModel: userViewModel), isActive: $isShowingSignInView){
                        Button {
                            isShowingSignInView = true
                        } label: {
                            Text("Sign In")
                                .foregroundColor(.blue)
                                .bold()
                                .underline()
                        }
                    }
                }
                
                Spacer()
            }
            .background(Image("background")
                            .resizable()
                            .scaledToFill()
                            .offset(y: -1)
                            .offset(x: 140)
                        .ignoresSafeArea()
            )
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // Sign up function to use Firebase to create a new user account in Firebase
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
//                print(error?.localizedDescription ?? "")
                alert = error?.localizedDescription ?? ""
                signUpSuccess = false
            } else {
                self.userViewModel.addNewUserData(email: email)
                signUpSuccess = true
                alert = "Successfully Sign Up"
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(userViewModel: UserViewModel())
    }
}
