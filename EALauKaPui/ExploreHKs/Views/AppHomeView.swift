//
//  AppHomeView.swift
//  LoginLauKaPui
//
//  Created by Cyrus on 12/10/2021.
//

import SwiftUI

struct AppHomeView: View {
    @State var user:String = ""
    var body: some View {
        VStack {
            Text("Hello \(user)")
                .font(Font.custom("Zapfino", size: 24))
            Text("Welcome! by LAU Ka Pui")
                .font(Font.custom("Zapfino", size: 20))
                .font(.subheadline)
            Text("You are signed in.")
        }
        .onAppear(perform: {self.user = UserDefaults.standard.object(forKey:"USERNAME") as? String ?? ""})
    }
}

struct AppHomeView_Previews: PreviewProvider {
    static var previews: some View {
        AppHomeView()
    }
}
