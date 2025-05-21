//
//  FavoritesModel+CoreDataProperties.swift
//  SPORTX
//
//  Created by moaz mamdouh on 21/05/2025.
//
//

import Foundation
import CoreData


extension FavoritesModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesModel> {
        return NSFetchRequest<FavoritesModel>(entityName: "FavoritesModel")
    }

    @NSManaged public var leagueId: Int32
    @NSManaged public var leagueImage: String?
    @NSManaged public var leagueName: String?
    @NSManaged public var leagueType: String?

}

extension FavoritesModel : Identifiable {

}
