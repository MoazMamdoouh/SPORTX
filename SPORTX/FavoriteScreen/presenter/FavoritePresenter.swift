//
//  FavoritePresenter.swift
//  SPORTX
//
//  Created by moaz mamdouh on 21/05/2025.
//

import Foundation


class FavoritePresenter {
    
    let coreDataRepo : CoreDataRepo
    
    var allLeagues : [FavoritesModel]?
    
    init(coreDataRepo: CoreDataRepo) {
        self.coreDataRepo = coreDataRepo
    }
    
    func getAllLeagues() -> [FavoritesModel] {
        allLeagues  = coreDataRepo.getAllLeagues()
        return allLeagues ?? []
    }
    
    func deleteLeague(leagueId: Int32) {
        coreDataRepo.deleteLeague(leagueId: leagueId)
    }
    
    func setupFixturePresenter(index : Int) -> FixturesPresenter?{
        guard let allLeagues else {return nil }
        let sportType = convertStringToSportType(name:  allLeagues[index].leagueType ?? "")
        return FixturesPresenter(sportsType: sportType, SportsRepo: SportRepoFactory.makeRepo(for: sportType), league : LeagueMapper.mapFromFavoriteModel(favoriteModel : allLeagues[index]))
    }
    
    private func convertStringToSportType(name : String) -> APIConstants.Sport {
        switch name {
        case "football":
            return .football
        case "tennis" :
            return .tennis
        case "cricket" :
            return .cricket
        case "basketball" :
            return .basketball
        default:
            return .football
        }
    }
    
}

extension LeagueMapper{
    static func mapFromFavoriteModel(favoriteModel : FavoritesModel) -> League{
        return League(leagueKey: Int(favoriteModel.leagueId), leagueName: favoriteModel.leagueName ?? "", leagueImage: favoriteModel.leagueImage ?? "")
    }
}
