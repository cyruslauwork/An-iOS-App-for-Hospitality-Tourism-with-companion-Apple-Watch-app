import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false // howToMakeAviewDismissItself
    
    var body: some View {
//        NavigationView {
            List{
                // clock
                VStack(alignment: .center) {
                    ClockView()
                }
                // clock end
                
                PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
                    .aspectRatio(3 / 2, contentMode: .fit)
                    .listRowInsets(EdgeInsets())
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Welcome To HK! 🇭🇰")
            // howToMakeAviewDismissItself
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost(isPresented: $showingProfile)
                    .environmentObject(modelData)
            }
            // howToMakeAviewDismissItself end
        
//        }
        
//#if os(iOS)
//        ExploreHKDetail(landmark: modelData.landmarks[6])
//            .environmentObject(modelData)
//#endif
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
