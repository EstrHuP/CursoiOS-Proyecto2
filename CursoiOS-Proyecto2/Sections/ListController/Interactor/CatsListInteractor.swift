//
//  CatsListInteractor.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 24/1/22.
//

import Foundation
import Alamofire

class CatsListInteractor: ListInteractorContract {
    
    private static var favoritesKey = "favorite.cats.array"
    
    var output: ListInteractorOutputContract?
    var catsProvider: CatsListProviderContract?
    
    private let userDefaults: UserDefaults
    
    //MARK: PERSISTENCIA DE DATOS
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    private var favorites: [String] {
        //obtener
        get {
            userDefaults.stringArray(forKey: CatsListInteractor.favoritesKey) ?? []
        }
        //guardar
        set {
            userDefaults.setValue(newValue, forKey: CatsListInteractor.favoritesKey)
        }
    }
    
    func fetchItems() {
        catsProvider?.getCatsList({ result in
            switch result {
            case .success(let cats): self.output?.didFetch(cats: cats)
            case .failure: self.output?.fetchDidFail()
            }
        })
    }
    
    func didPressFavorite(in cat: Cat) {
        if !favorites.contains(cat.id) {
            favorites.append(cat.id)
            output?.didUpdateFavorites(in: cat, favorite: true)
        } else if let index = favorites.firstIndex(of: cat.id) {
            favorites.remove(at: index)
            output?.didUpdateFavorites(in: cat, favorite: false)
        }
    }
    
    func isFavorite(cat: Cat) -> Bool {
        return favorites.contains(cat.id)
    }
}
