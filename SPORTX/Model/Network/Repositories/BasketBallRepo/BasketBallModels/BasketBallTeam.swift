//
//  BasketBallTeam.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 16/05/2025.
//

struct BasketBallTeamResponse: Decodable {
    let success: Int
    let result: [BasketBallTeam]
}

struct BasketBallTeam: Decodable {
    let team_key: Int
    let team_name: String
    let team_logo: String?
}
