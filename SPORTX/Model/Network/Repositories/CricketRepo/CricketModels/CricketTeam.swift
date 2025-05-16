//
//  CricketTeam.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 16/05/2025.
//

struct CricketTeamResponse: Decodable {
    let success: Int
    let result: [CricketTeam]
}

struct CricketTeam: Decodable {
    let team_key: Int
    let team_name: String
    let team_logo: String?

}

