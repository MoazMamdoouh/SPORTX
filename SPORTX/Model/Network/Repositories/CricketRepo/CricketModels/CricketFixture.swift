//
//  CricketFixture.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 16/05/2025.
//

struct CricketFixtureResponse: Decodable {
    let success: Int
    let result: [CricketFixture]
}

struct CricketFixture: Decodable {
    let event_date_start: String
    let event_time: String
    let event_home_team: String
    let home_team_key: Int
    let event_away_team: String
    let away_team_key: Int
    let event_home_final_result: String?
    let event_away_final_result: String?
    let event_status: String?
    let event_home_team_logo: String?
    let event_away_team_logo: String?
}
