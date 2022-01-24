//
//  CatsListInteractor.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 24/1/22.
//

import Foundation
import Alamofire

class CatsListInteractor: ListInteractorContract {
    var output: ListInteractorOutputContract?
    
    private var favorites = [String]()
    
    func fetchItems() {
        guard let url = URL(string: "https://cataas.com/api/cats") else {
            output?.fetchDidFail()
            return
        }
        
        let request = URLRequest(url: url)
        
        //MARK: Alamofire
        AF.request(request).responseDecodable { (response: DataResponse<[Cat], AFError>) in
            switch response.result {
            case .success(let cats): self.output?.didFetch(cats: cats)
            case .failure: self.output?.fetchDidFail()
            }
        }.validate()
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
