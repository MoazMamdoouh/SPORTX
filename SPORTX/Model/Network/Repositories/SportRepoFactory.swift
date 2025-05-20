//
//  SportRepoFactory.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 18/05/2025.
//

enum SportRepoFactory {
    static func makeRepo(for sport: APIConstants.Sport, withNetworkManager networkManager: NetworkManagerProtocol = NetworkManager.shared) -> any SportRepoProtocol {
        switch sport {
        case .football:
            return FootballRepo(networkManager: networkManager)
        case .basketball:
            return BasketballRepo(networkManager: networkManager)
        case .cricket:
            return CricketRepo(networkManager: networkManager)
        case .tennis:
            return TennisRepo(networkManager: networkManager)
        }
    }
}
