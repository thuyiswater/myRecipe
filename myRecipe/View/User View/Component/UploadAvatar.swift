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

struct UploadAvatar: View {
    @State var isPickerShowing: Bool = false
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        VStack{
            Button {
                isPickerShowing = true
            } label: {
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(50)
                } else {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 100))
                        .foregroundColor(Color("ForegroundColor"))
                }
            }
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil){
            ImagePicker(isPresented: $isPickerShowing, selectedImage: $selectedImage)
        }
    }
}

struct UploadAvatar_Previews: PreviewProvider {
    static var previews: some View {
        UploadAvatar(selectedImage: .constant(UIImage(named: "example")))
    }
}
