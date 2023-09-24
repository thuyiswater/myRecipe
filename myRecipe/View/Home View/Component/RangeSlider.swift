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

struct RangeSlider: View {
    @Binding var maxTimeMaking: Int
    @Binding var minTimeMaking: Int
    
    @State var width: Double = 0
    @State var width1: Double = UIScreen.main.bounds.width - 70
    var totalWidth = UIScreen.main.bounds.width - 70
    var body: some View {
        VStack {
            // Display the selected time range in hours and minutes.
            Text("\(minTimeMaking/60)h \(minTimeMaking%60)m - \(maxTimeMaking/60)h \(maxTimeMaking%60)m")
                .fontWeight(.bold)
                .padding(.top)
            
            // Create a range slider with a draggable thumb.
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.black.opacity(0.2))
                    .frame(width: totalWidth, height: 6)
                Rectangle()
                    .fill(Color.green.opacity(0.5))
                    .frame(width: self.width1 - self.width, height: 6)
                    .offset(x: self.width + 18)
                
                HStack(spacing: 0) {
                    // Left thumb for selecting the minimum time.
                    Circle()
                        .fill(Color.green)
                        .frame(width: 18, height: 18)
                        .offset(x: self.width)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    
                                    if (value.location.x >= 0 && value.location.x <= self.width1) {
                                        self.width = value.location.x
                                        minTimeMaking = Int(Double(getVal(val: self.width / self.totalWidth)) ?? 0.0)
                                    }
                                })
                        )
                    
                    // Right thumb for selecting the maximum time.
                    Circle()
                        .fill(Color.green)
                        .frame(width: 18, height: 18)
                        .offset(x: self.width1)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    
                                    if (value.location.x <= self.totalWidth && value.location.x >= self.width) {
                                        self.width1 = value.location.x
                                        maxTimeMaking = Int(Double(getVal(val: self.width1 / self.totalWidth)) ?? 0.0)
                                        }
                                })
                        )
                }
            }
        }.padding()
        .onAppear() {
            // Initialize the width of the thumbs based on the current time range.
            width = CGFloat(Double(minTimeMaking)/200)*self.totalWidth
            width1 = CGFloat(Double(maxTimeMaking)/200)*self.totalWidth
        }
    }
}

func getVal(val: CGFloat) -> String {
    return String(format: "%.f", val*200)
}

struct RangeSlider_Previews: PreviewProvider {
    @State static var minTimeMaking: Int = 0
    @State static var maxTimeMaking: Int = 180
    static var previews: some View {
        RangeSlider(maxTimeMaking: $maxTimeMaking, minTimeMaking: $minTimeMaking)
    }
}

