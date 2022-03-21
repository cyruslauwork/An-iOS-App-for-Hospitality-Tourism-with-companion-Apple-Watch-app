import SwiftUI

struct NotificationView: View {
    var title: String?
    var message: String?
    var landmark: ExploreHK?

    var body: some View {
        VStack {
            if landmark != nil {
                CircleImage(image: landmark!.image.resizable())
                    .scaledToFit()
            }

            Text(title ?? "Unknown Landmark")
                .font(.headline)

            Divider()

            Text(message ?? "You are within 5 miles of one of your favorite landmarks.")
                .font(.caption)
        }
        .lineLimit(0)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NotificationView()
            NotificationView(title: "Montane Mansion",
                             message: "You are within 5 miles of Montane Mansion.",
                             landmark: ModelData().landmarks[1])
        }

    }
}
