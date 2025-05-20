//
//  FixtureMapper.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 20/05/2025.
//

struct FixtureMapper {
    static func MapToFixture(forSport sport: APIConstants.Sport, fixture: Any) -> Fixture? {
        switch sport {
        case .football:
            guard let fixture = fixture as? FootballFixture else {
                return nil
            }
            return MapFromFootballFixture(footballFixture: fixture)
        case .basketball:
            guard let fixture = fixture as? BasketBallFixture else {
                return nil
            }
            return MapFromBasketballFixture(BasketballFixture: fixture)
        case .cricket:
            guard let fixture = fixture as? CricketFixture else {
                return nil
            }
            return MapFromCricketFixture(cricketFixture: fixture)
        case .tennis:
            guard let fixture = fixture as? TennisFixture else {
                return nil
            }
            return MapFromTennisFixture(tennisFixture: fixture)
        }
    }

    private static func MapFromFootballFixture(footballFixture: FootballFixture) -> Fixture {
        var finalResult: String?
        if footballFixture.event_final_result != "" && footballFixture.event_final_result != "-" {
            finalResult = footballFixture.event_final_result
        }
        return Fixture(homeTeamName: footballFixture.event_home_team,
                       awayTeamName: footballFixture.event_away_team,
                       homeTeamImage: footballFixture.home_team_logo ?? "",
                       awayTeamImage: footballFixture.away_team_logo ?? "",
                       date: footballFixture.event_date,
                       time: footballFixture.event_time,
                       finalResult: finalResult)
    }

    private static func MapFromBasketballFixture(BasketballFixture: BasketBallFixture) -> Fixture {
        var finalResult: String?
        if BasketballFixture.event_final_result != "" && BasketballFixture.event_final_result != "-" {
            finalResult = BasketballFixture.event_final_result
        }

        return Fixture(homeTeamName: BasketballFixture.event_home_team,
                       awayTeamName: BasketballFixture.event_away_team,
                       homeTeamImage: BasketballFixture.event_home_team_logo ?? "",
                       awayTeamImage: BasketballFixture.event_away_team_logo ?? "",
                       date: BasketballFixture.event_date,
                       time: BasketballFixture.event_time,
                       finalResult: finalResult)
    }

    private static func MapFromCricketFixture(cricketFixture: CricketFixture) -> Fixture {
        var finalResult: String?
        if let homeResult = cricketFixture.event_home_final_result, let awayResult = cricketFixture.event_away_final_result {
            if homeResult != "" && awayResult != "" && homeResult != "-" && awayResult != "-"{
                finalResult = homeResult + " - " + awayResult
            }
        }
        return Fixture(homeTeamName: cricketFixture.event_home_team,
                       awayTeamName: cricketFixture.event_away_team,
                       homeTeamImage: cricketFixture.event_home_team_logo ?? "",
                       awayTeamImage: cricketFixture.event_away_team_logo ?? "",
                       date: cricketFixture.event_date_start,
                       time: cricketFixture.event_time,
                       finalResult: finalResult)
    }

    private static func MapFromTennisFixture(tennisFixture: TennisFixture) -> Fixture {
        var finalResult: String?
        if tennisFixture.event_final_result != "" && tennisFixture.event_final_result != "-" {
            finalResult = tennisFixture.event_final_result
        }
        return Fixture(homeTeamName: tennisFixture.event_first_player,
                       awayTeamName: tennisFixture.event_second_player,
                       homeTeamImage: tennisFixture.event_first_player_logo ?? "",
                       awayTeamImage: tennisFixture.event_second_player_logo ?? "",
                       date: tennisFixture.event_date,
                       time: tennisFixture.event_time,
                       finalResult: finalResult)
    }
}
