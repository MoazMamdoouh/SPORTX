//
//  CoreDataRepo.swift
//  SPORTX
//
//  Created by moaz mamdouh on 21/05/2025.
//

import Foundation


protocol CoreDataRepo {
    
    func saveLeagueToFavorite(leagueId: Int32, leagueName: String, leagueImage: String, leagueType: String)
    
    func getAllLeagues() -> [FavoritesModel]
    
    func deleteLeague(leagueId: Int32)
}
