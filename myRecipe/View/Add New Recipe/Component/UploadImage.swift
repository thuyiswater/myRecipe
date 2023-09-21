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

struct UploadImage: View {
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
                        .frame(width: 360, height: 200)
                        .cornerRadius(10)
                } else {
                    Image(systemName: "photo")
                        .font(.system(size: 160))
                        .foregroundColor(Color("ForegroundColor"))
                }
            }

        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil){
            ImagePicker(isPresented: $isPickerShowing, selectedImage: $selectedImage)
        }
    }
}

struct UploadImage_Previews: PreviewProvider {
    static var previews: some View {
        UploadImage(selectedImage: .constant(UIImage(named: "example")))
    }
}
