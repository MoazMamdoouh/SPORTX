//
//  APIConstants.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

import Foundation


struct APIConstants {
    static let baseURL = "https://apiv2.allsportsapi.com"
    static let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String

    enum Sport: String {
        case football, tennis, cricket, basketball
    }

    enum Met: String {
        case leagues = "Leagues"
        case fixtures = "Fixtures"
        case teams = "Teams"
        case players = "Players"
    }
}
