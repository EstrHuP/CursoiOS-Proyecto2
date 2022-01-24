//
//  CatsListPresenter.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 24/1/22.
//

import Foundation

class CatsListPresenter: ListPresenterContract {
    
    var view: ListViewContract?
    var interactor: ListInteractorContract?
    var wireframe: CatListWireframeContract?
    
    private var cats = [Cat]() {
        didSet {
            view?.reloadData()
        }
    }
    
    private var favorites = [String]()
    
    var numItems: Int {
        return cats.count
    }
    
    func viewDidLoad() {
        interactor?.output = self
        interactor?.fetchItems()
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ListTableCellViewModel {
        let item = cats[indexPath.row]
        return item.toListCellViewModel
    }
    
    func isFavorite(at indexPath: IndexPath) -> Bool {
        let item = cats[indexPath.row]
        return favorites.contains(item.id)
    }
    
    func didSelectFavorite(at indexPath: IndexPath) {
        let item = cats[indexPath.row]
        
        if !favorites.contains(item.id) {
            favorites.append(item.id)
            view?.setFavorite(true, at: indexPath)
        } else if let index = favorites.firstIndex(of: item.id) {
            favorites.remove(at: index)
            view?.setFavorite(false, at: indexPath)
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let cat = cats[indexPath.row]
        wireframe?.navigate(to: cat)
    }
    
    private func fetchData() {
        interactor?.fetchItems()
    }
}

extension CatsListPresenter: ListInteractorOutputContract {
    func didFetch(cats: [Cat]) {
        self.cats = cats
    }
    
    func fetchDidFail() {
        print("Error")
    }
}
