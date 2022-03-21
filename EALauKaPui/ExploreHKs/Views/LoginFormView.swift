//
//  LoginFormView.swift
//  LoginLauKaPui
//
//  Created by Cyrus on 12/10/2021.
//

import SwiftUI

struct LoginFormView: View {
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var showError = false
    @State private var message: String = ""
    @Binding var signInSuccess: Bool
    
    var body: some View {
        VStack{
            HStack{
                Text("User name")
                TextField("type here", text: $userName)
            }
            .padding()
            .autocapitalization(.none)
            .disableAutocorrection(true)
            HStack{
                Text("Password")
                SecureField("type here", text: $password)
                .textContentType(.password)
            }.padding()
            Button(action: {
                // Your auth logic
                login()
            }) {
                Text("Sign in")
            }
            
            if showError{
                Text(message)
                    .foregroundColor(Color.red)
                    .padding()
            }
        }
    }
    
    private func login() {
        let username = userName
        let password = password
        
        let post:String = "username=\(username)&password=\(password)"
        
        print("PostData: \(post)");
        
        let url:URL = URL(string: "http://localhost/2d1LauKaPui/login.php")!
        
        let postData:Data = post.data(using: String.Encoding(rawValue:String.Encoding.utf8.rawValue))!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postData
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) {
            urlData, response, reponseError in
            
            if let receivedData = urlData {
                let res = response as? HTTPURLResponse;
                print("Response code: \(res!.statusCode)");
                if ((res!.statusCode) >= 200 && (res!.statusCode) < 300)
                {
                    let responseData:NSString = NSString(data:receivedData, encoding:String.Encoding.utf8.rawValue)!
                    print("Response ==> \(responseData)");
                    let lastChar = responseData.character(at: responseData.length - 1)
                    let success = Int(lastChar) - 48
                    if(success == 0){
                        let prefs:UserDefaults = UserDefaults.standard
                        prefs.set(username, forKey: "USERNAME")
                        prefs.set(1, forKey: "ISLOGGEDIN")
                        prefs.synchronize()
                        signInSuccess = true
                    } else {
                        var error_msg:String
                        switch responseData.intValue {
                        case 1: error_msg = "DB connection error"
                        case 2: error_msg = "invalid user data"
                        case 3: error_msg = "Invalid Username / Password doesn't match"
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
        task.resume()
    }
    
    private func alertMessage(_ alertText:String){
        message = alertText
        showError = true
    }
} //end of ContentViews

//struct LoginFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginFormView()
//    }
//}
