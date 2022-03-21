//
//  SettingsView.swift
//  WeatherEverywhere
//
//  Created by Cyrus on 25/11/2021.
//

import SwiftUI

struct SettingsView: View {
    @State private var sideMenuActived: Bool = false // sidemenu
    
    @EnvironmentObject var settings: SettingsStore
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var
    horizontalSizeClass
#endif
    //    var title: some View {
    //        Text(" Settings").font(.title).bold()
    //    }
    
    var body: some View {
        VStack(alignment: .leading) {
            //#if os(iOS)
            //            if horizontalSizeClass != .compact {
            //                title
            //            }
            //#elseif os(macOS)
            //            title
            //#endif
            
            // sidemenu
            ZStack {
                ZStack {
                    BackgroundView()
                }
                
                ZStack {
                    // BG border
                    RoundedRectangle(cornerRadius: sideMenuActived ? 32 : 0)
                        .foregroundColor(Color.blue)
                        .shadow(radius: sideMenuActived ? 32 : 0)
                    VStack {
                        // item
                        HStack {
                            Button(action: { self.sideMenuActived.toggle() }) {
                                Image(uiImage: sideMenuActived ? closeImage : menuListImage).accentColor(Color.black)
                                    .frame(width: 44, height: 44, alignment: .center)
                                    .scaleEffect(sideMenuActived ? 2 : 1)
                            }.padding(.top, 64).padding(.leading, 32)
                            Spacer()
                        }
                        Divider()
                        // item2
                        Spacer()
                        GeometryReader { geo in // howBigIsTheContainer?
                            Toggle("Temperature in °C", isOn: $settings.showCelsius)
                                .foregroundColor(Color.white.opacity(0.8))
                                .padding(geo.size.width * 0.1)
                        }
                        // item3
                        Spacer()
                        GeometryReader { geo in // howBigIsTheContainer?
                            Text("Version: Alpha 0.1.0")
                                .foregroundColor(Color.white.opacity(0.8))
                                .font(.system(size: 17, weight: .regular))
                                .italic()
                                .padding(geo.size.width * 0.1)
                        }
                    }
                }
                .offset(x: sideMenuActived ? 354 : 0)
                .scaleEffect(sideMenuActived ? 0.7 : 1)
                .animation(.spring(response: 0.5)).edgesIgnoringSafeArea(.all)
            }
            // sidemenu end
            
        }//.padding(50).navigationTitle(Text(" Settings"))
    }
}

// sidemenu
struct BackgroundView: View {
    var body: some View {
        GeometryReader { geo in // howBigIsTheContainer?
            Text("by LAU Ka Pui 200137474\nDE114102D-2D1")
                .foregroundColor(Color.gray.opacity(0.8))
                .font(.system(size: 17, weight: .regular))
                .italic()
                .padding(geo.size.width * 0.1)
        }
    }
}
// sidemenu end

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
