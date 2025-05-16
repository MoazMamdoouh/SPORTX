//
//  BasketBallLeague.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

struct BasketBallLeagueResponse: Decodable {
    let success: Int
    let result: [BasketBallLeague]
}

struct BasketBallLeague: Decodable {
    let league_key: Int
    let league_name: String
}
