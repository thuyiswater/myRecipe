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

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    @State private var isShowingFilter: Bool = false
    @Binding var minTimeMaking: Int
    @Binding var maxTimeMaking: Int
    @Binding var category: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("ForegroundColor"))
                .font(.system(size: 18))
                .bold()

            TextField(placeholder, text: $text)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("BackgroundColor"))
                )
                .foregroundColor(Color("ForegroundColor"))
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            Text("|")
            
            Button {
                isShowingFilter = true
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(Color("ForegroundColor"))
                    .font(.system(size: 18))
                    .bold()
            }
        }
        .padding(.horizontal, 16)
        .background(RoundedRectangle(cornerRadius: 30).fill(Color("BackgroundColor")))
        .sheet(isPresented: $isShowingFilter) {
            FilterView(minTimeMaking: $minTimeMaking, maxTimeMaking: $maxTimeMaking, category: $category)
                .presentationDetents([.medium])
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State private static var minTimeMaking: Int = 0
    @State private static var maxTimeMaking: Int = 180
    @State private static var category: String = "None"
    static var previews: some View {
        VStack{
            Spacer()
            SearchBar(text: .constant(""), placeholder: "", minTimeMaking: $minTimeMaking, maxTimeMaking: $maxTimeMaking, category: $category)
            Spacer()
        }
        .background(.gray.opacity(0.2))
    }
}
