/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Le Tran Minh Trung
  ID: s3927071
  Created  date: 15/09/2023
  Last modified: 17/09/2023)
  Acknowledgement:
*/
import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var minTimeMaking: Int
    @Binding var maxTimeMaking: Int
    @Binding var category: String
    
    let catergoryArr: [String] = ["None", "Breakfast", "Lunch", "Dinner", "Dessert", "Smoothies"]
    
    var body: some View {
        VStack{
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 28))
                        .bold()
                        .opacity(0)
                }

                Spacer()

                Text("Filter Result")
                    .font(.system(size: 32))
                    .padding(.top, 20)

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 28))
                        .foregroundColor(Color("ForegroundColor"))
                        .bold()
                }
            }
            
            .padding(.horizontal, 20)
            .padding(.bottom,20)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15){
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text("Category")
                            .font(.system(size: 20))
                            .foregroundColor(.secondary)
                        
                        SelectButton(array: catergoryArr, selection: $category)
                    }
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text("Making Time")
                            .font(.system(size: 20))
                            .foregroundColor(.secondary)
                        
                        RangeSlider(maxTimeMaking: $maxTimeMaking, minTimeMaking: $minTimeMaking)
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .background(Color.gray.opacity(0.2))
    }
}

struct FilterView_Previews: PreviewProvider {
    @State static var category: String = "None"
    @State static var minMakingTime: Int = 0
    @State static var maxMakingTime: Int = 180
    static var previews: some View {
        FilterView(minTimeMaking: $minMakingTime, maxTimeMaking: $maxMakingTime, category: $category)
    }
}
