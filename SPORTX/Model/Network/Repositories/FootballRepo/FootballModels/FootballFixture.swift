//
//  FootballFixture.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 16/05/2025.
//

struct FootballFixtureResponse: Decodable {
    let success: Int
    let result: [FootballFixture]
}

struct FootballFixture: Decodable {
    let event_date: String
    let event_time: String
    let event_home_team: String
    let home_team_key: Int
    let event_away_team: String
    let away_team_key: Int
    let event_final_result: String?
    let event_status: String?
    let league_name: String
    let home_team_logo: String?
    let away_team_logo: String?
    let league_logo: String?
}
