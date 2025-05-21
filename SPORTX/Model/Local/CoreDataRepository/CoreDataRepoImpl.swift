//
//  CoreDataRepoImpl.swift
//  SPORTX
//
//  Created by moaz mamdouh on 21/05/2025.
//

import Foundation

class CoreDataRepoImpl : CoreDataRepo {

        
    static let shared = CoreDataRepoImpl()
    
    private init() {}
    
    func saveLeagueToFavorite(leagueId: Int32, leagueName: String, leagueImage: String, leagueType: String) {
        
        CoreDataManager.shared.saveLeagueToFavorite(leagueId: leagueId, leagueName: leagueName, leagueImage: leagueImage, leagueType: leagueType)
        
    }
    
    func getAllLeagues() -> [FavoritesModel] {
       
       return  CoreDataManager.shared.getAllLeagues()
       
    }
    
    func deleteLeague(leagueId: Int32) {
        CoreDataManager.shared.deleteLeague(leagueId: leagueId)
    }
    
    
    func checkLeagueInCoreData(leagueId: Int32) -> Bool {
        return CoreDataManager.shared.checkLeagueInCoreData(leagueId: leagueId)
    }
    
}
