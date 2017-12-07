//
//  User.swift
//  TripPlanner
//
//  Created by Tia King on 12/6/17.
//  Copyright © 2017 Tia King. All rights reserved.
//

import Foundation
struct User:Codable {
    let email: String
    let password: String
}
struct Trip:Codable {
    let destination: String
    let tripDates: Int
    let waypoints: String
}
