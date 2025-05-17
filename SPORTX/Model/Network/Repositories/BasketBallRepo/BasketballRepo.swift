//
//  BasketballRepo.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

class BasketballRepo: SportsRepoProtocol {
    typealias LeagueType = BasketBallLeague

    typealias FixtureType = BasketBallFixture

    typealias TeamOrPlayerType = BasketBallTeam

    let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getLeagues(completion: @escaping ([BasketBallLeague]?) -> Void
    ) {
        let params = [String: String]()

        networkManager.fetchData(
            sport: .basketball,
            met: .leagues,
            parameters: params,
            responseType: BasketBallLeagueResponse.self
        ) { res in
            if let res = res {
                completion(res.result)
                return
            }
            completion(nil)
        }
    }

    func getFixtures(leagueId: Int, completion: @escaping ([BasketBallFixture]?) -> Void) {
        let startEndDate = DatesGenerator.generateDates(numberOfDaysBefore: 20, numberOfDaysAfter: 20)

        let params = [
            "from": startEndDate.startDate,
            "to": startEndDate.endDate,
            "leagueId": "\(leagueId)",
            "timezone": "egypt",
        ]

        networkManager.fetchData(
            sport: .basketball,
            met: .fixtures,
            parameters: params,
            responseType: BasketBallFixtureResponse.self
        ) { res in
            if let res = res {
                completion(res.result)
                return
            }
            completion(nil)
        }
    }

    func getTeamsOrPlayers(leagueId: Int, completion: @escaping ([BasketBallTeam]?) -> Void) {
        let params = [
            "leagueId": "\(leagueId)",
        ]

        networkManager.fetchData(
            sport: .basketball,
            met: .teams,
            parameters: params,
            responseType: BasketBallTeamResponse.self
        ) { res in
            if let res = res {
                completion(res.result)
                return
            }
            completion(nil)
        }
    }
}
