//
//  FootballLeague.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

struct FootballLeagueResponse: Decodable {
    let success: Int
    let result: [FootballLeague]
}

struct FootballLeague: Decodable {
    let league_key: Int
    let league_name: String
    let league_logo: String?
}
