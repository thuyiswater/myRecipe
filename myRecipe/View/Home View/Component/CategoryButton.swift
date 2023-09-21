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

struct CategoryButton: View {
    var category: Category
    var width: CGFloat
    
    var body: some View {
        VStack {
            VStack {
                
                Image(category.image)
                
                
                HStack{
                    Spacer()
                    Text(category.name.en)
                        .font(.system(size: 8))
                    Spacer()
                }
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("BackgroundColor"))
            )
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.secondary)
            )
        }
        .frame(width: width)
    }
}

struct CategoryButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButton(category: Category.categories[0], width: 180.0)
    }
}
