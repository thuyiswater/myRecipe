/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Vi Phi Long
  ID: s3904632
  Created  date: 06/09/2023
  Last modified: 11/09/2023
  Acknowledgement:
*/

import SwiftUI

struct LandingView: View {
    @StateObject var userViewModel = UserViewModel()
    @State private var isShowingSignInView: Bool = false
    @State private var isShowingSignUpView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                
                Text("myRecipe")
                    .font(.custom("Didot", size: 62))
                    .foregroundColor(.black)
                    .bold()
                
                Spacer()
                
                VStack{
                    NavigationLink(destination: SignUpView(userViewModel: userViewModel), isActive: $isShowingSignUpView){
                        Button {
                            isShowingSignUpView = true
                        } label: {	
                            Text("Sign Up with myRecipe")
                                .bold()
                                .foregroundColor(Color.white)
                                .frame(width: 360, height: 50)
                                .background(Color("PrimaryColor"))
                                .cornerRadius(10)
                                .padding(.bottom, 10)
                        }
                    }
                    
                    NavigationLink(destination: SignInView(userViewModel: userViewModel), isActive: $isShowingSignInView){
                        Button {
                            isShowingSignInView = true
                        } label: {
                            Text("Sign in")
                                .bold()
                                .foregroundColor(Color.white)
                                .frame(width: 360, height: 50)
                                .background(Color.gray.opacity(0.6))
                                .cornerRadius(10)
                                .padding(.bottom, 30)
                        }
                    }
                }
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
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
