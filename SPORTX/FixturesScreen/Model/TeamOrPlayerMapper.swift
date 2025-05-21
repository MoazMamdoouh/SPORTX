//
//  TeamOrPlayerMapper.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 20/05/2025.
//

struct TeamOrPlayerMapper {
    static func MapToTeamOrPlayer(forSport sport: APIConstants.Sport, teamOrPlayer: Any) -> TeamOrPlayer? {
        switch sport {
        case .football:
            guard let teamOrPlayer = teamOrPlayer as? FootballTeam else {
                return nil
            }
            return MapFromFootballTeam(footballTeam: teamOrPlayer)
        case .basketball:
            guard let teamOrPlayer = teamOrPlayer as? BasketBallTeam else {
                return nil
            }
            return MapFromBasketballTeam(basketballTeam: teamOrPlayer)
        case .cricket:
            guard let teamOrPlayer = teamOrPlayer as? CricketTeam else {
                return nil
            }
            return MapFromCricketTeam(cricketTeam: teamOrPlayer)
        case .tennis:
            guard let teamOrPlayer = teamOrPlayer as? TennisPlayer else {
                return nil
            }
            return MapFromTennisPlayer(tennisPlayer: teamOrPlayer)
        }
    }

    private static func MapFromFootballTeam(footballTeam: FootballTeam) -> TeamOrPlayer {
        var players: [Player] = []
        for player in footballTeam.players {
            let tempPlayer = Player(name: player.player_name, number: player.player_number, image: player.player_image ?? "")
            players.append(tempPlayer)
        }
        let coach = Coach(name: footballTeam.coaches[0].coach_name)
        return TeamOrPlayer(key: footballTeam.team_key,
                            name: footballTeam.team_name,
                            image: footballTeam.team_logo ?? "",
                            players: players, coachOrCountry: coach)
    }

    private static func MapFromBasketballTeam(basketballTeam: BasketBallTeam) -> TeamOrPlayer {
        return TeamOrPlayer(key: basketballTeam.team_key, name: basketballTeam.team_name, image: basketballTeam.team_logo ?? "")
    }

    private static func MapFromCricketTeam(cricketTeam: CricketTeam) -> TeamOrPlayer {
        return TeamOrPlayer(key: cricketTeam.team_key, name: cricketTeam.team_name, image: cricketTeam.team_logo ?? "")
    }

    private static func MapFromTennisPlayer(tennisPlayer: TennisPlayer) -> TeamOrPlayer {
        return TeamOrPlayer(key: tennisPlayer.player_key, name: tennisPlayer.player_name, image: tennisPlayer.player_logo ?? "", coachOrCountry: Coach(name: tennisPlayer.player_country ?? ""))
    }
}
