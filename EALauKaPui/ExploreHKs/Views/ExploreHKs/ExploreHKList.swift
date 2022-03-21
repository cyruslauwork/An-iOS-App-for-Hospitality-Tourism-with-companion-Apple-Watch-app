import SwiftUI

struct ExploreHKList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    
    var filteredExploreHKs: [ExploreHK] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    
    var body: some View {
#if os(watchOS)
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(filteredExploreHKs) { landmark in
                    NavigationLink {
                        ExploreHKDetail(landmark: landmark)
                    } label: {
                        ExploreHKRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Activities in HK")
        }
#endif
#if os(iOS)
        List {
            Toggle(isOn: $showFavoritesOnly) {
                Text("Favorites only")
            }
            
            ForEach(filteredExploreHKs) { landmark in
                NavigationLink {
                    ExploreHKDetail(landmark: landmark)
                } label: {
                    ExploreHKRow(landmark: landmark)
                }
            }
        }
        .navigationTitle("Activities in HK")
        
//        ExploreHKDetail(landmark: modelData.landmarks[2])
//            .environmentObject(modelData)
#endif
    }
}

struct ExploreHKList_Previews: PreviewProvider {
    static var previews: some View {
        ExploreHKList()
            .environmentObject(ModelData())
    }
}
