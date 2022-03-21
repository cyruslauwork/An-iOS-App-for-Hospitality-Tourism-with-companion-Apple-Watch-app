import SwiftUI

struct TripDetail: View {
    let trip: Trip
    @State var dataToShow = \Trip.Observation.visited

    var buttons = [
        ("Visited", \Trip.Observation.visited),
        ("Stay Time", \Trip.Observation.stayTime),
        ("Pace", \Trip.Observation.pace)
    ]

    var body: some View {
        VStack {
            TripGraph(trip: trip, path: dataToShow)
                .frame(height: 200)

            HStack(spacing: 25) {
                ForEach(buttons, id: \.0) { value in
                    Button {
                        dataToShow = value.1
                    } label: {
                        Text(value.0)
                            .font(.system(size: 15))
                            .foregroundColor(value.1 == dataToShow
                                ? .gray
                                : .accentColor)
                            .animation(nil)
                    }
                }
            }
        }
    }
}

struct TripDetail_Previews: PreviewProvider {
    static var previews: some View {
        TripDetail(trip: ModelData().trips[0])
    }
}
