//
//  QuakeFetcher.swift
//  iOS6-Quakes
//
//  Created by Paul Solt on 7/11/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import Foundation

enum QuakeError: Int, Error {
    case invalidURL
    case noDataReturned
}


class QuakeFetcher {
    let baseURL = URL(string: "https://earthquake.usgs.gov/fdsnws/event/1/query")!
    let dateFormatter = ISO8601DateFormatter()
    
    func fetchQuakes(from dateInterval: DateInterval,
                     completion: @escaping ([Quake]?, Error?) -> Void) {
        
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        // startTime, endTime, format
        let startTime = dateFormatter.string(from: dateInterval.start)
        let endTime = dateFormatter.string(from: dateInterval.end)
        
        let queryItems = [
            URLQueryItem(name: "starttime", value: startTime),
            URLQueryItem(name: "endtime", value: endTime),
            URLQueryItem(name: "format", value: "geojson")
        ]

        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            print("Error creating URL from components")
            completion(nil, QuakeError.invalidURL)
            return
        }
        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching quakes: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("No data")
                completion(nil, QuakeError.noDataReturned)
                return
            }
            
            // Parsing
        }
    }
    
    
}