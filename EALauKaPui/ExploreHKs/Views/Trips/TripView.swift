import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

struct TripView: View {
    var trip: Trip
    @State private var showDetail = false

    var body: some View {
        VStack {
            HStack {
                TripGraph(trip: trip, path: \.visited)
                    .frame(width: 50, height: 30)

                VStack(alignment: .leading) {
                    Text(trip.name)
                        .font(.headline)
                    Text(trip.distanceText)
                }

                Spacer()

                Button {
                    withAnimation {
                        showDetail.toggle()
                    }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                }
            }

            if showDetail {
                TripDetail(trip: trip)
                    .transition(.moveAndFade)
            }
        }
    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TripView(trip: ModelData().trips[0])
                .padding()
            Spacer()
        }
    }
}
