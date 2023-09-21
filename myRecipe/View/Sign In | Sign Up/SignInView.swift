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

struct SignInView: View {
    var userViewModel: UserViewModel
    @State var email = ""
    @State var password = ""
    @State var loginSuccess = false
    @State private var isShowingSignUpView = false
    @State private var alert: String = ""
    @StateObject private var recipeViewModel: RecipeViewModel = RecipeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Spacer()
                Spacer()
                
                VStack{
                    Text("Sign In")
                        .foregroundColor(.black)
                        .font(.system(size: 40))
                        .bold()
                    
                    Text(alert)
                        .bold()
                        .foregroundColor(.red)
                }.padding(.top, 30)
                
                Spacer()
                
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
                        .padding(.bottom, 30)
                        .onTapGesture {
                            // Clear the alert when the Password TextField is tapped
                            alert = ""
                        }
                }
                .padding(.horizontal, 10)
                
                // Login button
                Button(action: {
                    login()
                }) {
                    Text("Sign In")
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 300, height: 50)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(10)
                        .padding(.bottom, 50)
                }
                .background(
                    NavigationLink("", destination: AppView(email: email, userViewModel: userViewModel, recipeViewModel: recipeViewModel), isActive: $loginSuccess)
                )
                
                HStack{
                    Text("You don't have an account?")
                        .foregroundColor(.black)
                    NavigationLink(destination: SignUpView(userViewModel: userViewModel), isActive: $isShowingSignUpView){
                        Button {
                            isShowingSignUpView = true
                        } label: {
                            Text("Sign Up")
                                .foregroundColor(.blue)
                                .bold()
                                .underline()
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 15)
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
    
    // Login function to use Firebase to check username and password to sign in
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
//                print(error?.localizedDescription ?? "")
                alert = error?.localizedDescription ?? ""
                loginSuccess = false
            } else {
                loginSuccess = true
            }
        }
    }
}

struct SignInViewView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(userViewModel: UserViewModel())
    }
}
