//
//  TennisRepo.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

class TennisRepo: SportsRepoProtocol {
    typealias LeagueType = TennisLeague

    typealias FixtureType = TennisFixture

    typealias TeamOrPlayerType = TennisPlayer

    let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getLeagues(completion: @escaping ([TennisLeague]?) -> Void
    ) {
        let params = [String: String]()

        networkManager.fetchData(
            sport: .tennis,
            met: .leagues,
            parameters: params,
            responseType: TennisLeagueResponse.self
        ) { res in
            if let res = res {
                completion(res.result)
                return
            }
            completion(nil)
        }
    }

    func getFixtures(leagueId: Int, completion: @escaping ([TennisFixture]?) -> Void) {
        let startEndDate = DatesGenerator.generateDates(numberOfDaysBefore: 1000, numberOfDaysAfter: 100)

        let params = [
            "from": startEndDate.startDate,
            "to": startEndDate.endDate,
            "leagueId": "\(leagueId)",
            "timezone": "egypt",
        ]

        networkManager.fetchData(
            sport: .tennis,
            met: .fixtures,
            parameters: params,
            responseType: TennisFixtureResponse.self
        ) { res in
            if let res = res {
                completion(res.result)
                return
            }
            completion(nil)
        }
    }

    func getTeamsOrPlayers(leagueId: Int, completion: @escaping ([TennisPlayer]?) -> Void) {
        let params = [
            "leagueId": "\(leagueId)",
        ]
        networkManager.fetchData(
            sport: .tennis,
            met: .players,
            parameters: params,
            responseType: TennisPlayerResponse.self
        ) { res in
            if let res = res {
                completion(res.result)
                return
            }
            completion(nil)
        }
    }
}
