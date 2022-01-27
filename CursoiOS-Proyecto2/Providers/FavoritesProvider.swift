//
//  FavoritesProvider.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 26/1/22.
//

import Foundation

enum FavoritesProviderError: Error {
    
}

protocol FavoritesProvider {
    func didUpdateFavorite(id: String, _ completion: @escaping (Result<Bool, Error>) -> ())
    func isFavorite(id: String) -> Bool
}

class UserDefaultsFavoritesProvider: FavoritesProvider {
    
    private let userDefaults: UserDefaults
    
    private static var favoritesKey = "favorite.cats.array"
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    
    private var favorites: [String] {
        //obtener
        get {
            userDefaults.stringArray(forKey: UserDefaultsFavoritesProvider.favoritesKey) ?? []
        }
        //guardar
        set {
            userDefaults.setValue(newValue, forKey: UserDefaultsFavoritesProvider.favoritesKey)
        }
    }
    
    func didUpdateFavorite(id: String, _ completion: @escaping (Result<Bool, Error>) -> ()) {
        if !favorites.contains(id) {
            favorites.append(id)
            completion(.success(true))
        } else if let index = favorites.firstIndex(of: id) {
            favorites.remove(at: index)
            completion(.success(false))
        }
    }
    
    func isFavorite(id: String) -> Bool {
        return favorites.contains(id)
    }
}
