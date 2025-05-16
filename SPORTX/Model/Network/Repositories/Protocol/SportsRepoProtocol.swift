//
//  SportsRepoProtocol.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 16/05/2025.
//

protocol SportsRepoProtocol {
    associatedtype LeagueType: Decodable
    associatedtype FixtureType: Decodable
    associatedtype TeamOrPlayerType: Decodable

    func getLeagues(completion: @escaping ([LeagueType]?) -> Void)
    func getFixtures(leagueId: Int, completion: @escaping ([FixtureType]?) -> Void)
    func getTeamsOrPlayers(leagueId: Int, completion: @escaping ([TeamOrPlayerType]?) -> Void)
}
