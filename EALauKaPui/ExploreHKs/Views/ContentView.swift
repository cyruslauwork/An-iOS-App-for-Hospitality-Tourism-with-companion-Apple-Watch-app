import SwiftUI

struct ContentView: View {
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }// iPadOS/iOS
    
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false
    
    @State private var selection: Tab = .featured
    
    enum Tab {
        case featured
        case list
        case myWeather
        case settings
    }
    
    var body: some View {
        // iPadOS/iOS
        if idiom == .pad {
            iPadOSView()
            Spacer()
        } else {
            iOSView()
        }
        // iPadOS/iOS end
    }
}

struct iPadOSView: View {
    @State private var selection: Tab = .featured
    enum Tab {
        case featured
        case list
        case myWeather
        case settings
    }
    var body: some View {
        TabView(selection: $selection) {
            NavigationView{
                Divider()
                CategoryHome()
            }.tabItem {
                Label("Featured", systemImage: "star")
            }
            .tag(Tab.featured)
            
            NavigationView{
                Divider()
                ExploreHKList()
            }.tabItem {
                Label("List", systemImage: "list.bullet")
            }
            .tag(Tab.list)
            
            NavigationView{
                Divider()
                MyWeatherView()
            }.tabItem{
                Label("My Weather", systemImage: "thermometer.sun.fill")
                    .accessibility(label: Text("My Weather"))
            }.tag(Tab.myWeather)
            
            SettingsView()
                .tabItem{
                    Label("Settings", systemImage: "gear")
                        .accessibility(label: Text("Settings"))
                }.tag(Tab.settings)
        }
    }
}
struct iOSView: View {
    @State private var selection: Tab = .featured
    enum Tab {
        case featured
        case list
        case myWeather
        case settings
    }
    var body: some View {
        TabView(selection: $selection) {
            NavigationView{
                CategoryHome()
            }.tabItem {
                Label("Featured", systemImage: "star")
            }
            .tag(Tab.featured)
            
            NavigationView{
                ExploreHKList()
            }.tabItem {
                Label("List", systemImage: "list.bullet")
            }
            .tag(Tab.list)
            
            NavigationView{
                MyWeatherView()
            }.tabItem{
                Label("My Weather", systemImage: "thermometer.sun.fill")
                    .accessibility(label: Text("My Weather"))
            }.tag(Tab.myWeather)
            
            SettingsView()
                .tabItem{
                    Label("Settings", systemImage: "gear")
                        .accessibility(label: Text("Settings"))
                }.tag(Tab.settings)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
