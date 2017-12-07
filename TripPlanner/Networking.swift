//
//  Networking.swift
//  TripPlanner
//
//  Created by Tia King on 12/6/17.
//  Copyright © 2017 Tia King. All rights reserved.
//

import Foundation

class Networking {
    
    let baseURL = "http://localhost:5000"
    let session = URLSession.shared
    
    func request(resource: Resource, completion: @escaping ([Decodable]) -> ()) {
        let fullUrl = baseURL.appending(resource.path())
        let url = URL(string: fullUrl)!
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = resource.headers()
        request.httpMethod = resource.httpMethod().rawValue
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            print(response)
            guard error == nil else {
                return
            }
        })
        
        task.resume()
    }
        
    }














