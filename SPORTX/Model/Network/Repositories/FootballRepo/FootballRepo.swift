//
//  FootballRepo.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

class FootballRepo: SportRepoProtocol {
    typealias LeagueType = FootballLeague

    typealias FixtureType = FootballFixture

    typealias TeamOrPlayerType = FootballTeam

    let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getLeagues(completion: @escaping ([FootballLeague]?) -> Void
    ) {
        let params = [String: String]()

        networkManager.fetchData(
            sport: .football,
            met: .leagues,
            parameters: params,
            responseType: FootballLeagueResponse.self
        ) { res in
            if let res = res {
                completion(res.result)
                return
            }
            completion(nil)
        }
    }

    func getFixtures(leagueId: Int, completion: @escaping ([FootballFixture]?) -> Void) {
        let startEndDate = DatesGenerator.generateDates(numberOfDaysBefore: 5, numberOfDaysAfter: 5)

        let params = [
            "from": startEndDate.startDate,
            "to": startEndDate.endDate,
            "leagueId": "\(leagueId)",
            "timezone": "egypt",
        ]

        networkManager.fetchData(
            sport: .football,
            met: .fixtures,
            parameters: params,
            responseType: FootballFixtureResponse.self
        ) { res in
            if let res = res {
                completion(res.result)
                return
            }
            completion(nil)
        }
    }

    func getTeamsOrPlayers(leagueId: Int, completion: @escaping ([FootballTeam]?) -> Void) {
        let params = [
            "leagueId": "\(leagueId)",
        ]

        networkManager.fetchData(
            sport: .football,
            met: .teams,
            parameters: params,
            responseType: FootballTeamResponse.self
        ) { res in
            if let res = res {
                completion(res.result)
                return
            }
            completion(nil)
        }
    }
}
