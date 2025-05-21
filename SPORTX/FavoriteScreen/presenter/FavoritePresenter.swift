//
//  FavoritePresenter.swift
//  SPORTX
//
//  Created by moaz mamdouh on 21/05/2025.
//

import Foundation


class FavoritePresenter {
    
    let coreDataRepo : CoreDataRepo
    
    init(coreDataRepo: CoreDataRepo) {
        self.coreDataRepo = coreDataRepo
    }
    
    func getAllLeagues() -> [FavoritesModel] {
        
        return coreDataRepo.getAllLeagues()
    }
    
    
}
