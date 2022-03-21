import SwiftUI

// howToMakeAviewDismissItself2
struct DismissingView2: View {
    @Binding var isPresented: Bool
    
    // signup
    @State private var username = ""
    @State private var newPassword = ""
    @State private var confirmedPassword = ""
    @State private var showingAlert = false
    @State private var message = ""
    // signup end
    
    var body: some View {
        // signup
        return Group {
            Spacer()
            NavigationView {
                Form {
                    // Form fields
                    TextField("Username", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $newPassword)
                    SecureField("Confirm New Password", text: $confirmedPassword)
                    
                    if self.isPasswordValid() {
                        Button(action: {
                            print("signup")
                            signup()
                        }, label: {
                            Text("Sign Up")
                        }).alert(isPresented: $showingAlert) {
                            Alert(title: Text("Login Status"), message: Text("\(message)"), dismissButton: .default(Text("OK")))
                        }
                    }
                    
                }.navigationBarTitle(Text("Registration Form"))
            }
            Spacer()
            Button("Cancel") {
                isPresented = false
            }
        }
    }
    private func isPasswordValid() -> Bool {
        if !newPassword.isEmpty && newPassword == confirmedPassword {
            return true
        }
        return false
    }
    private func signup() {
        let username = username
        let password = newPassword
        let confirm_password = confirmedPassword
        let post:String = "username=\(username)&password=\(password)&c_password=\(confirm_password)"
        print("PostData: \(post)");
        let url:URL = URL(string: "http://localhost/2d1LauKaPui/signup.php")!
        let postData:Data = post.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postData
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { urlData, response, reponseError in
            if let receivedData = urlData {
                let res = response as? HTTPURLResponse;
                print("Response code: \(res!.statusCode)");
                if ((res!.statusCode) >= 200 && (res!.statusCode) < 300)
                {
                    let responseData:NSString = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                    print("Response ==> \(responseData)");
                    let lastChar = responseData.character(at: responseData.length - 1)
                    //                    print("lastChar=\(lastChar)")
                    let success = Int(lastChar) - 48
                    //                    print("success=\(success)")
                    if(success == 0)
                    {
                        alertMessage("Sign Up SUCCESS");
                    } else {
                        var error_msg:String
                        switch success {
                        case 1: error_msg = "Database connection error"
                        case 2: error_msg = "Invalid input data"
                        case 3: error_msg = "Username exists"
                        case 4: error_msg = "passwords do not match"
                        default:error_msg = "Unspecified error"
                        }
                        alertMessage(error_msg)
                    }
                } else {
                    alertMessage("Connection Failed")
                }
            } else {
                var message = "Connection Failure"
                if let error = reponseError {
                    message = (error.localizedDescription)
                }
                alertMessage(message)
            }
        }
        task.resume() //optional
    }
    private func alertMessage(_ err_msg:String){
        message = err_msg
        showingAlert = true
    }
    // signup end
}
struct DismissingView: View {
    @Binding var isPresented: Bool
    
    @State private var showingDetail2 = false
    
    @State var signInSuccess = false // signin
    
    var body: some View {
        // signin
        return Group {
            if signInSuccess {
                AppHomeView()
            } else {
                LoginFormView(signInSuccess: $signInSuccess)
            }
            Divider()
            Button("Sign up") {
                showingDetail2 = true
            }
            .sheet(isPresented: $showingDetail2) {
                DismissingView2(isPresented: $showingDetail2)
            }
            Button("Cancel") {
                isPresented = false
            }
        }
        // signin end
    }
}
// howToMakeAviewDismissItself2 end

struct ProfileHost: View {
    @Binding var isPresented: Bool // howToMakeAviewDismissItself
    
    @State private var showingDetail = false // howToMakeAviewDismissItself2
    
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                // howToMakeAviewDismissItself
                Button("Back") {
                    isPresented = false
                }
                // howToMakeAviewDismissItself end
                
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                    .onDisappear {
                        modelData.profile = draftProfile
                    }
            }
            
            // howToMakeAviewDismissItself2
            Button("Sign in") {
                showingDetail = true
            }
            .sheet(isPresented: $showingDetail) {
                DismissingView(isPresented: $showingDetail)
            }
            // howToMakeAviewDismissItself2 end
        }
        .padding()
    }
}

//struct ProfileHost_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHost()
//            .environmentObject(ModelData())
//    }
//}
