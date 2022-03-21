//
//  DataRequest.swift
//  Weather
//
//  Created by Brian Advent on 05.01.19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import Foundation
import CoreLocation

enum GetDataRequest<Type> {
    case success([Type])
    case failure
}

struct DataRequest<Type> where Type : Decodable{
    let basePath = "https://explorecalifornia.org/api/weather/city/"
    let dataURL:URL
    
    init(city: String) {
        let dataPathString = (basePath + city).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        guard let dataURL = URL(string: dataPathString) else {fatalError()}
        
        self.dataURL = dataURL
    }
    
    func getData (completion: @escaping (GetDataRequest<Type>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: dataURL) {data, response, error in
            
            guard let jsonData = data else {completion(.failure); return}
            do {
                let resources = try JSONDecoder().decode([Type].self, from: jsonData)
                completion(.success(resources))
            }catch{
                
                completion(.failure)
            }
        }
        
        dataTask.resume()
        
    }
}
