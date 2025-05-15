//
//  Leagues.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

struct LeagueResponse: Decodable {
    let success: Int
    let result: [League]
}

struct League: Decodable {
    let league_key: Int
    let league_name: String
    let league_logo: String?
}
