//
//  FootballTeam.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 16/05/2025.
//

struct FootballTeamResponse: Decodable {
    let success: Int
    let result: [FootballTeam]
}

struct FootballTeam: Decodable {
    let team_key: Int
    let team_name: String
    let team_logo: String?
    let players: [FootballPlayer]
    let coaches: [FootballCoach]
}

struct FootballPlayer: Decodable{
    let player_name:String
    let player_number:String
    let player_image: String?
}

struct FootballCoach: Decodable {
    let coach_name:String
}
