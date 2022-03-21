//
//  WeatherDetail.swift
//  WeatherEverywhere
//
//  Created by Brian Advent on 11.10.20.
//

import SwiftUI

struct WeatherDetail: View {
    @EnvironmentObject var settings: SettingsStore
    var forecast:Forecast
    var backgroundColor: Color {
#if os(macOS)
        return Color(.textBackgroundColor)
#else
        return Color(.secondarySystemBackground)
#endif
    }
    
    var body: some View {
        Group{
#if os(iOS)
            container
#else
            container.frame(minWidth: 500, idealWidth: 700, maxWidth:
                                    .infinity, minHeight: 300, maxHeight: .infinity)
#endif
        }
        .padding()
        .background(Rectangle().fill(BackgroundStyle()).edgesIgnoringSafeArea(. all))
        .navigationTitle("🗓 \(forecast.date)")
    }
    
    var container: some View {
        VStack (alignment: .leading, spacing: 20){
            VStack(alignment: .leading){
                Text(forecast.condition_desc) .font(Font.title).bold().padding()
            }.onDrag{
                return NSItemProvider(object:forecast.condition_desc as
                                      NSString)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(backgroundColor)
            .cornerRadius(16)
            Text("What to expect ...")
                .font(Font.title).bold()
                .foregroundColor(.accentColor)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 130), spacing: 16, alignment: .top)], alignment: .center, spacing: 16) {
                minTempContent.onDrag{
                    return NSItemProvider(object:String(forecast.temp_min) as NSString)
                }
                maxTempContent.onDrag{
                    return NSItemProvider(object:String(forecast.temp_max) as NSString)
                }
                conditionIconContent
            }
            Spacer()
        }
    }
    
    var maxTempContent: some View {
        VStack{
            ZStack{
                Rectangle()
                    .fill(Color("maxTempBackground"))
                    .frame(width: 150, height: 150)
                    .cornerRadius(16)
                if settings.showCelsius {
                    Text("\(Int((forecast.temp_max - 32) * (5/9))) °C").foregroundColor(.white)
                        .font(.largeTitle)
                }else{
                    Text("\(Int(forecast.temp_max)) °F").foregroundColor(.white)
                        .font(.largeTitle)
                }
            }
            Text("High")
        }
    }
    
    var minTempContent: some View {
        VStack{
            ZStack{
                Rectangle()
                    .fill(Color("minTempBackground"))
                    .frame(width: 150, height: 150)
                    .cornerRadius(16)
                if settings.showCelsius {
                    Text("\(Int((forecast.temp_min - 32) * (5/9))) °C").foregroundColor(.white)
                        .font(.largeTitle)
                }else{
                    Text("\(Int(forecast.temp_min)) °F").foregroundColor(.white)
                        .font(.largeTitle)
                }
            }
            Text("Low")
        }
    }
    
    var conditionIconContent: some View {
        VStack{
            ZStack{
                Rectangle()
                    .fill(Color("conditionBackground"))
                    .frame(width: 150, height: 150)
                    .cornerRadius(16)
                Image(systemName: Icon.systemIconForCondition(condition: forecast.condition_name))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            Text("Condition")
        }
    }
}

struct WeatherDetail_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetail(forecast:
                        Forecast(date: "11/10/46", temp_min: 10, temp_max: 20,
                                 conditionName: "Windy", conditionDescription: "Attention! It is windy"))
                                 }
                                 }
