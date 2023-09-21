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

struct TabBarButton: View {
    var image: String
    var selectedTab: String
    
    var body: some View {
        VStack(spacing: 10){
            Image(systemName: image)
                .foregroundColor(selectedTab == image ? Color("PrimaryColor") : Color("ForegroundColor"))
                .font(.system(size: 32))
                .frame(height: 30)
            
            if selectedTab == image{
                Circle()
                    .fill(Color("PrimaryColor"))
                    .frame(width: 8, height: 8)
            }
        }
    }
}

//struct TabBarButton_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarButton()
//    }
//}
