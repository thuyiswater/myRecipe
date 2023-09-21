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

struct TimePicker: View {
    @Binding var makingTime: Int
    
    var body: some View {
        HStack {
            TextField("Making Time", value: $makingTime, formatter: NumberFormatter())
                .textInputAutocapitalization(.none)
            
            Text("|  Minutes")
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(10)
    }
}


struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        TimePicker(makingTime: .constant(0))
    }
}
