//
//  TennisPlayer.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 16/05/2025.
//

struct TennisPlayerResponse: Decodable {
    let success: Int
    let result: [TennisPlayer]
}

struct TennisPlayer: Decodable {
    let player_key: Int
    let player_name: String
    let player_country: String?
    let player_logo: String?
}
