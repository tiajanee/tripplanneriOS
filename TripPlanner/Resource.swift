//
//  Resource.swift
//  TripPlanner
//
//  Created by Tia King on 12/6/17.
//  Copyright © 2017 Tia King. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
struct BasicAuth {
    static let tj = "TJ"
    static func generateBasicAuthHeader(email: String, password: String) -> String {
        let loginString = String(format: "%@:%@", email, password)
        let loginData: Data = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString(options: .init(rawValue: 0))
        let authHeaderString = "Basic \(base64LoginString)"
        return authHeaderString
    }
}

enum Resource {
    case getUser(email: String, password: String)
    case createUser(email: String, password: String)
    case createTrip(destination: String, tripDates: Int, waypoints: String)
    case getTrip(destination:String, tripDates:Int, waypoints: String)
    
    func httpMethod() -> HTTPMethod {
        switch self {
        case .getUser:
            return .get
        case .createUser:
            return .post
        case .createTrip:
            return .post
        case .getTrip:
            return .get
        }
    }
    
    func body() -> Data? {
        switch self {
        case .getUser:
            return nil
        case let .createUser(email, password):
            let user = User(email: email, password: password)
            let data = try? JSONEncoder().encode(user)
            return data
        case let .createTrip(destination, tripDates, waypoints):
            let trip = Trip(destination: destination, tripDates: tripDates, waypoints: waypoints)
            let data = try? JSONEncoder().encode(trip)
            return data
        case .getTrip:
            return nil
        }
    }
    
    func path() -> String {
        switch self {
        case .getUser, .createUser:
            return "/users"
        case .getTrip, .createTrip:
            return "/trips"
        }
    }
    
    func parameters() -> [String: String] {
        switch self {
        case .createUser:
            return [:]
        case .getUser:
            return [:]
        case .createTrip:
            return [:]
        case .getTrip:
            return [:]
        }
    }
    func headers() -> [String: String] {
        switch self {
        case .createUser:
            return [:]
        case let .getUser(email, password):
            let auth = BasicAuth.generateBasicAuthHeader(email: email, password: password)
            return ["Authorization": "\(auth)", "Accept": "application/json", "Content-Type": "application/json", "Host": "https://tripplannerproduction.herokuapp.com/"]
        case let .getTrip(destination, tripDates, waypoints):
//            let auth = BasicAuth.generateBasicAuthHeader(destination: destination, tripDates: tripDates, waypoints: waypoints)
            return ["Authorization": "\(auth)", "Accept": "application/json", "Content-Type": "application/json", "Host": "https://tripplannerproduction.herokuapp.com/"]
        case .createTrip:
            return [:]
        }
    }
}
