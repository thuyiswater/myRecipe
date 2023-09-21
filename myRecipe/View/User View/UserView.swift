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

//check if thewre ia an avatar no need to upload a new one

import SwiftUI
import FirebaseStorage

struct UserView: View {
    //MARK: Properties
    @Environment(\.dismiss) var dismiss
    @Binding var user: User
    @ObservedObject var userViewModel: UserViewModel
    @State private var isEditMode: Bool = false
    @State private var isShowingSettingView: Bool = false
    @State private var logOut: Bool = false
    @State private var isShowingAlert: Bool = false
    
    // Fields for editing user information
    @State private var editedFirstName: String = ""
    @State private var editedLastName: String = ""
    @State private var editedDOB: String = ""
    @State private var editedGender: String = ""
    @State private var editedEmail: String = ""
    @State private var editedPhone: String = ""
    @State private var editedAddress: String = ""
    @State private var selectedImage: UIImage?
    @State private var avatar: UIImage = UIImage()
    
    @State private var isUpdating: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        //MARK: Top Buttons
                        HStack(spacing: 10){
                            Button {
                                isEditMode.toggle()      // Set initial values for editing fields
                                editedFirstName = user.firstName ?? ""
                                editedLastName = user.lastName ?? ""
                                editedDOB = user.dob ?? ""
                                editedGender = user.gender ?? ""
                                editedEmail = user.email
                                editedPhone = user.phone ?? ""
                                editedAddress = user.address ?? ""
                            } label: {
                                Image(systemName: "pencil.tip")
                                    .foregroundColor(Color("ForegroundColor"))
                                    .font(.system(size: 24))
                                    .bold()
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 20)
                                    .background(Color("PrimaryColor"))
                                    .cornerRadius(20)
                            }
                            
                            Button {
                                isShowingSettingView = true
                            } label: {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(Color("ForegroundColor"))
                                    .font(.system(size: 24))
                                    .bold()
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 20)
                                    .background(.thinMaterial)
                                    .cornerRadius(20)
                            }
                            .background(NavigationLink("", destination: SettingView(), isActive: $isShowingSettingView))
                            
                            Spacer()
                            
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .foregroundColor(Color("ForegroundColor"))
                                    .font(.system(size: 24))
                                    .bold()
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 20)
                                    .background(.thinMaterial)
                                    .cornerRadius(20)
                            }
                        }
                        
                        //MARK: User Info
                        if isEditMode{
                            UploadAvatar(selectedImage: $selectedImage)
                        } else {
                            if user.avatar != "" {
                                Image(uiImage: avatar)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(50)
                            } else {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(50)
                            }
                        }

                        VStack(alignment: .leading){
                            HStack{
                                Text("General")
                                    .foregroundColor(Color("PrimaryColor").opacity(0.6))
                                    .font(.system(size: 32))
                                    .bold()
                                    .padding(.bottom, 30)

                                Spacer()
                            }

                            VStack(alignment: .leading, spacing: 10){
                                HStack{
                                    VStack(alignment: .leading, spacing: 10){
                                        Text("First Name:")
                                        
                                        if isEditMode {
                                            TextField("First Name", text: $editedFirstName)
                                                .font(.system(size: 22))
                                                .bold()
                                        } else {
                                            Text(user.firstName ?? "")
                                                .font(.system(size: 22))
                                                .bold()
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .leading, spacing: 10){
                                        Text("Last Name:" )
                                        
                                        if isEditMode {
                                            TextField("Last Name", text: $editedLastName)
                                                .font(.system(size: 22))
                                                .bold()
                                        } else {
                                            Text(user.lastName ?? "")
                                                .font(.system(size: 22))
                                                .bold()
                                        }
                                    }
                                    
                                    Spacer()
                                }

                                Text("Date of Birth:")

                                if isEditMode {
                                    TextField("Date of Birth", text: $editedDOB)
                                        .font(.system(size: 22))
                                        .bold()
                                } else {
                                    Text(user.dob ?? "")
                                        .font(.system(size: 22))
                                        .bold()
                                }
                            }
                            .padding(.bottom, 10)

                            VStack(alignment: .leading, spacing: 10){
                                Text("Gender:")

                                if isEditMode {
                                    TextField("Gender", text: $editedGender)
                                        .font(.system(size: 22))
                                        .bold()
                                } else {
                                    Text(user.gender ?? "")
                                        .font(.system(size: 22))
                                        .bold()
                                }

                                Text("Email:")

                                Text(user.email)
                                    .font(.system(size: 22))
                                    .bold()
                            }
                            .padding(.bottom, 10)

                            VStack(alignment: .leading, spacing: 10){
                                Text("Phone:")

                                if isEditMode {
                                    TextField("Phone", text: $editedPhone)
                                        .font(.system(size: 22))
                                        .bold()
                                } else {
                                    Text(user.phone ?? "")
                                        .font(.system(size: 22))
                                        .bold()
                                }

                                Text("Address:")

                                if isEditMode {
                                    TextField("Address", text: $editedAddress)
                                        .font(.system(size: 22))
                                        .bold()
                                } else {
                                    Text(user.address ?? "")
                                        .font(.system(size: 22))
                                        .bold()
                                }
                            }
                        }
                        .padding()
                        .background(.thinMaterial)
                        .cornerRadius(20)

                        Spacer()
                        
                        //MARK: Save Button
                        // Save button when in edit mode
                        if isEditMode {
                            Button(action: {
                                handleSaveButton()
                            }) {
                                Text("Save")
                                    .bold()
                                    .foregroundColor(Color.white)
                                    .frame(width: 300, height: 50)
                                    .background(Color("PrimaryColor"))
                                    .cornerRadius(10)
                                    .padding(.bottom, 30)
                            }
                        }
                    }
                    .padding(.top, 50)
                    .padding()
                }
                //MARK: Alert
                .alert(isPresented: $isShowingAlert){
                    Alert(
                        title: Text("Unable to Upload the Avatar"),
                        message: Text("There is an error occured" + "during the uploading.")
                )}
                .onAppear{
                    retrieveImage()
                }
                .background(Color.gray.opacity(0.2))
                .ignoresSafeArea()
                
                if isUpdating{
                    LoadingScreen()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    //MARK: Function
    func handleSaveButton() {
        isUpdating = true
        
        var updatedUser = User(
            firstName: editedFirstName,
            lastName: editedLastName,
            dob: editedDOB,
            gender: editedGender,
            email: editedEmail,
            phone: editedPhone,
            address: editedAddress,
            favourite: user.favourite,
            avatar: "",
            documentID: user.documentID
        )
        
        if selectedImage != nil {
            // Upload the image and capture the path
            userViewModel.uploadPhoto(selectedImage: selectedImage) { path in
                if let path = path {
                    // Update the user object with the edited values and the image path
                    updatedUser.avatar = path
                    user = updatedUser
                    userViewModel.updateUserData(user: updatedUser)
                    retrieveImage()
                    isUpdating = false
                } else {
                    isUpdating = false
                    isShowingAlert = true
                }
            }
        } else {
            user = updatedUser
            print(user)
            
            userViewModel.updateUserData(user: updatedUser)
        }
    }
    
    func retrieveImage() {
        // Retrieve data
        let path = user.avatar ?? ""
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child(path)
        
        let maxSize: Int64 = Int64(5) * Int64(1024) * Int64(1024)
            
        fileRef.getData(maxSize: maxSize) { data, error in
            // Check for errors and data
            if error == nil, let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.avatar = image // Update the avatar on the main thread
                }
            } 
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: .constant(User(firstName: "Long", lastName: "Nguyen",dob: "16/03/2000", gender: "Male", email: "viphilongnguyen@gmail.com", phone: "0834160300", address: "", favourite: [], avatar: "", documentID: "")), userViewModel: UserViewModel())
    }
}
