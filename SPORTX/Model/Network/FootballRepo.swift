//
//  FootballRepo.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

class FootballRepo {
    static func getLeagues(completion: @escaping ([League]?) -> Void
    ) {
        let params = [String: String]()

        NetworkManager.shared.fetchData(
            sport: .football,
            met: .leagues,
            parameters: params,
            responseType: LeagueResponse.self
        ) {res in
            if let res = res {
                completion(res.result)
                return
            }
            completion(nil)
        }
    }

//    static func getMatches() {
//        let params = [
//            "from": "2024-01-01",
//            "to": "2026-01-01",
//            "leagueId": "4195"
//        ]
//    }
}
