//
//  CricketLeague.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

struct CricketLeagueResponse: Decodable {
    let success: Int
    let result: [CricketLeague]
}

struct CricketLeague: Decodable {
    let league_key: Int
    let league_name: String
}
