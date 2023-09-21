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

struct SelectButton: View {
    var array: [String]
    @Binding var selection: String
    
    var body: some View {
        HStack {
            Menu {
                ForEach(array, id: \.self) { element in
                    Button(action: {
                        selection = element
                    }) {
                        Label(element, systemImage: selection == element ? "checkmark" : "")
                            .foregroundColor(Color("ForegroundColor"))
                    }
                }
            } label: {
                Label(selection, systemImage: "chevron.down")
                    .foregroundColor(Color("ForegroundColor"))
                    .bold()
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct SelectButton_Previews: PreviewProvider {
    static var previews: some View {
        SelectButton(array: ["none","breakfast", "lunch", "dinner"], selection: .constant("none"))
    }
}
