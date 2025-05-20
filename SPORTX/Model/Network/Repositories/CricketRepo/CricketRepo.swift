//
//  CricketRepo.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

class CricketRepo: SportRepoProtocol {
    typealias LeagueType = CricketLeague

    typealias FixtureType = CricketFixture

    typealias TeamOrPlayerType = CricketTeam

    let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getLeagues(completion: @escaping ([CricketLeague]?) -> Void
    ) {
        let params = [String: String]()

        networkManager.fetchData(
            sport: .cricket,
            met: .leagues,
            parameters: params,
            responseType: CricketLeagueResponse.self
        ) { res in
            if let res = res {
                completion(res.result)
                return
            }
            completion(nil)
        }
    }

    func getFixtures(leagueId: Int, completion: @escaping ([CricketFixture]?) -> Void) {
        let startEndDate = DatesGenerator.generateDates(numberOfDaysBefore: 1000, numberOfDaysAfter: 100)

        let params = [
            "from": startEndDate.startDate,
            "to": startEndDate.endDate,
            "leagueId": "\(leagueId)",
            "timezone": "egypt",
        ]

        networkManager.fetchData(
            sport: .cricket,
            met: .fixtures,
            parameters: params,
            responseType: CricketFixtureResponse.self
        ) { res in
            if let res = res {
                completion(res.result)
                return
            }
            completion(nil)
        }
    }

    func getTeamsOrPlayers(leagueId: Int, completion: @escaping ([CricketTeam]?) -> Void) {
        let params = [
            "leagueId": "\(leagueId)",
        ]
        networkManager.fetchData(
            sport: .cricket,
            met: .teams,
            parameters: params,
            responseType: CricketTeamResponse.self
        ) { res in
            if let res = res {
                completion(res.result)
                return
            }
            completion(nil)
        }
    }
}
