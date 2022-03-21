import SwiftUI

struct ExploreHKDetail: View {
    @EnvironmentObject var modelData: ModelData
    var landmark: ExploreHK

    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)

            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                }

                HStack {
                    Text(landmark.shortDesc)
                    Spacer()
                    Text(landmark.district)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }
            .padding()
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExploreHKDetail_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        ExploreHKDetail(landmark: modelData.landmarks[0])
            .environmentObject(modelData)
    }
}
