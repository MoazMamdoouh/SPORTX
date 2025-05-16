//
//  TennisFixture.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 16/05/2025.
//

struct TennisFixtureResponse: Decodable {
    let success: Int
    let result: [TennisFixture]
}

struct TennisFixture: Decodable {
    let event_date: String
    let event_time: String
    let event_first_player: String
    let first_player_key: Int
    let event_second_player: String
    let second_player_key: Int
    let event_final_result: String?
    let event_status: String?
    let league_name: String?
    let event_first_player_logo: String?
    let event_second_player_logo: String?
}
