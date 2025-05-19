//
//  LeagueMapper.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 19/05/2025.
//

struct LeagueMapper {
    static func MapToLeague(forSport sport: APIConstants.Sport, league: Any) -> League? {
        switch sport {
        case .football:
            guard let league = league as? FootballLeague else {
                return nil
            }
            return MapFromFootballLeague(footballLeague: league)
        case .basketball:
            guard let league = league as? BasketBallLeague else {
                return nil
            }
            return MapFromBasketball(BasketballLeague: league)
        case .cricket:
            guard let league = league as? CricketLeague else {
                return nil
            }
            return MapFromCricketLeague(cricketLeague: league)
        case .tennis:
            guard let league = league as? TennisLeague else {
                return nil
            }
            return MapFromTennisLeague(tennisLeague: league)
        }
    }

    private static func MapFromFootballLeague(footballLeague: FootballLeague) -> League {
        return League(leagueKey: footballLeague.league_key, leagueName: footballLeague.league_name, leagueImage: footballLeague.league_logo ?? "")
    }

    private static func MapFromBasketball(BasketballLeague: BasketBallLeague) -> League {
        return League(leagueKey: BasketballLeague.league_key, leagueName: BasketballLeague.league_name, leagueImage: "")
    }

    private static func MapFromCricketLeague(cricketLeague: CricketLeague) -> League {
        return League(leagueKey: cricketLeague.league_key, leagueName: cricketLeague.league_name, leagueImage: "")
    }

    private static func MapFromTennisLeague(tennisLeague: TennisLeague) -> League {
        return League(leagueKey: tennisLeague.league_key, leagueName: tennisLeague.league_name, leagueImage: "")
    }
}
