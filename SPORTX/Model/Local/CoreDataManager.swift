//
//  CoreDataManager.swift
//  SPORTX
//
//  Created by moaz mamdouh on 21/05/2025.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    private var context: NSManagedObjectContext {
            return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        }
        
        func saveLeagueToFavorite(leagueId: Int32, leagueName: String, leagueImage: String, leagueType: String) {
            let favorite = FavoritesModel(context: context)
            favorite.leagueId = leagueId
            favorite.leagueName = leagueName
            favorite.leagueImage = leagueImage
            favorite.leagueType = leagueType
            
            do {
                try context.save()
                print(" League saved to favorites.")
            } catch {
                print("Failed to save league: \(error.localizedDescription)")
            }
        }
    
    func getAllLeagues() -> [FavoritesModel] {
        let fetchRequest: NSFetchRequest<FavoritesModel> = FavoritesModel.fetchRequest()
        
        do {
            let favoriteLeagues = try context.fetch(fetchRequest)
            return favoriteLeagues
        } catch {
            print("Failed to fetch leagues: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteLeague(leagueId: Int32) {
        let fetchRequest: NSFetchRequest<FavoritesModel> = FavoritesModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", leagueId)
        
        do {
            let results = try context.fetch(fetchRequest)
            for league in results {
                context.delete(league)
            }
            try context.save()
            print("League deleted successfully.")
        } catch {
            print("Failed to delete league: \(error.localizedDescription)")
        }
    }
}
