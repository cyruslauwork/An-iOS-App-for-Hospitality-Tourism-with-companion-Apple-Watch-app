import SwiftUI

@main
struct ExploreHKsApp: App {
    @StateObject private var modelData = ModelData()
    @StateObject var settings = SettingsStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(settings)
        }

        #if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: "ExploreHKNear")
        #endif
    }
}
