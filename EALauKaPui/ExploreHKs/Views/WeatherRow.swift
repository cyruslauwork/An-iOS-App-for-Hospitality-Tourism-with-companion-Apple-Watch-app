//
//  WeatherRow.swift
//  WeatherEverywhere
//
//  Created by Brian Advent on 13.10.20.
//

import SwiftUI

struct WeatherRow: View {
    struct Metrics{
        var iconsSize: CGFloat
        var iconPadding: CGFloat
        var rowPadding: CGFloat
    }
    var metrics: Metrics {
#if os(iOS)
        return Metrics(iconsSize: 25, iconPadding: 10, rowPadding: 10)
#else
        return Metrics(iconsSize: 15, iconPadding: 5, rowPadding: 5)
#endif
    }
    
    var forecast: Forecast
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName:Icon.systemIconForCondition(condition: forecast.condition_name))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: metrics.iconsSize, height: metrics.iconsSize)
                .padding(.trailing, metrics.iconPadding)
                .accessibility(hidden: true)
            VStack(alignment: .leading) {
                Text(forecast.condition_name)
                    .font(.headline) .lineLimit(1)
                Text(forecast.condition_desc)
                    .lineLimit(2)
            }
            Spacer(minLength: 0)
        }
        .font(.subheadline)
        .padding(.vertical, metrics.rowPadding)
        .accessibilityElement(children: .combine)
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(forecast: Forecast(date: "11/10/46", temp_min: 10,
                                      temp_max: 20, conditionName: "Windy", conditionDescription:
                                        "Attention! It is windy"))
    }
}
