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
        do {
        let leagues =  try CoreDataManager.shared.getAllLeagues()
            
         return leagues
            
        }catch {
            print("Failed to fetch leagues in repo : \(error.localizedDescription)")
        }
    }
    
    func deleteLeague(leagueId: Int32) {
        print("delete item called ")
    }
    
    
    
}
