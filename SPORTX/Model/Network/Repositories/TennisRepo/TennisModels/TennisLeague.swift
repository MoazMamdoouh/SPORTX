//
//  TennisLeague.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

struct TennisLeagueResponse: Decodable {
    let success: Int
    let result: [TennisLeague]
}

struct TennisLeague: Decodable {
    let league_key: Int
    let league_name: String
}
