//
//  CatsListInteractor.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 24/1/22.
//

import Foundation

class CatsListInteractor: ListInteractorContract {
    
    //Output = delegate
    weak var output: ListInteractorOutputContract?
    
    var catsProvider: CatsListProviderContract?
    var favoritesProvider: FavoritesProvider?
    
    func fetchItems() {
        catsProvider?.getCatsList({ result in
            switch result {
            case .success(let cats): self.output?.didFetch(cats: cats)
            case .failure: self.output?.fetchDidFail()
            }
        })
    }
    
    func didPressFavorite(in cat: Cat) {
        favoritesProvider?.didUpdateFavorite(id: cat.id, { result in
            switch result {
            case .success(let favorite): self.output?.didUpdateFavorites(in: cat, favorite: favorite)
            case .failure: break
            }
        })
    }
    
    func isFavorite(cat: Cat) -> Bool {
        return favoritesProvider?.isFavorite(id: cat.id) ?? false
    }
    
    //MARK: Gestion de memoria
    deinit {
        print("deinit \(self)")
    }
}
