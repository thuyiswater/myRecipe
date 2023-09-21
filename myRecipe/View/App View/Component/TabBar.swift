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

struct TabBar: View {
    @Binding var isShowingAddNewRecipe: Bool
    @Binding var selectedTab: String

    var body: some View {
        HStack{
            Button {
                selectedTab = "house.fill"
            } label: {
                TabBarButton(image: "house.fill", selectedTab: selectedTab)
            }
            .padding(.top, 10)

            Spacer()

            Button {
                selectedTab = "heart.fill"
            } label: {
                TabBarButton(image: "heart.fill", selectedTab: selectedTab)
            }
            .padding(.top, 10)

            Spacer()

            Button {
                isShowingAddNewRecipe = true
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("BackgroundColor"))
                    .padding(25)
                    .background(Color("PrimaryColor"))
                    .clipShape(Circle())
            }
            .offset(y: -35)

            Spacer()

            Button {
                selectedTab = "list.clipboard.fill"
            } label: {
                TabBarButton(image: "list.clipboard.fill", selectedTab: selectedTab)
            }
            .padding(.top, 10)

            Spacer()

            Button {
                selectedTab = "person.fill"
            } label: {
                TabBarButton(image: "person.fill", selectedTab: selectedTab)
            }
            .padding(.top, 10)
        }
        .padding(.top)
        .padding(.horizontal, 10)
        .padding(.vertical, -15)
        .background(Color("BackgroundColor"))
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(isShowingAddNewRecipe: .constant(false),selectedTab: .constant("house.fill"))
    }
}
