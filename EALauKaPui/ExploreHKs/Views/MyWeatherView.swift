//
//  MyWeatherView.swift
//  WeatherEverywhere
//
//  Created by Brian Advent on 08.10.20.
//

import SwiftUI

struct MyWeatherView: View {
    @State private var forecasts = [Forecast]()
    
    @State private var selection:Forecast?
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
       List(selection: $selection) {
            ForEach(forecasts) { forecast in
                NavigationLink(destination: WeatherDetail(forecast: forecast), tag: forecast, selection: $selection) {
                    WeatherRow(forecast: forecast)
                    
                }
                
            }
        }.onAppear(perform: loadData).background(Rectangle().fill(BackgroundStyle()).edgesIgnoringSafeArea(.all))
        .navigationTitle("🌤 Forecast")
        
//        ExploreHKDetail(landmark: modelData.landmarks[23])
//            .environmentObject(modelData)
    
    }
    
    func loadData(){
        let weatherDataReqeust = DataRequest<WeatherData>(city: "Hong Kong")
        
        weatherDataReqeust.getData{ dataResult in
            switch dataResult {
            case .failure:
                print("Could not load weater data")
            case .success(let weatherDataObjects):
                guard let forecastArray = weatherDataObjects.first?.forecast else {return}
                DispatchQueue.main.async {
                    self.forecasts = forecastArray
                }
            
            }
        }
    }
}

struct MyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        MyWeatherView()
    }
}
