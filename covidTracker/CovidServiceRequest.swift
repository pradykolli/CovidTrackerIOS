//
//  CovidServiceRequest.swift
//  covidTracker
//
//  Created by pradeep Kolli on 3/25/20.
//  Copyright © 2020 pradeep Kolli. All rights reserved.
//

import Foundation

class CovidServiceRequest:URLSession {
    
    let headers = [
        "x-rapidapi-host": "covid-193.p.rapidapi.com",
        "x-rapidapi-key": "554a0664a6mshd03eb0ca9f9d535p14f556jsn71a88dc87bed"
    ]
    
    private static let requestEndpoint:String = "https://covid-193.p.rapidapi.com/statistics"
    
//    private static let requestEndpointNinja:String = "https://corona.lmao.ninja/countries"
    func fetchCovidCases(completion: @escaping (Result<[Countries], Error>) -> ()) {
        
        guard let url = URL(string: CovidServiceRequest.requestEndpoint) else { return }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 10.0
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request){ (data, response, error) -> Void in
            if let error = error {
                completion(.failure(error))
                return
            }
            do{
                let responseInfo = try JSONDecoder().decode(CovidCases.self, from: data!)
                completion(.success(responseInfo.response))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}



