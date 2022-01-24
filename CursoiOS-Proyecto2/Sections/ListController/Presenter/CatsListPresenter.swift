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
        return interactor?.isFavorite(cat: item) ?? false
    }
    
    func didSelectFavorite(at indexPath: IndexPath) {
        let item = cats[indexPath.row]
        interactor?.didPressFavorite(in: item)
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
    
    func didUpdateFavorites(in cat: Cat, favorite: Bool) {
        guard let index = cats.firstIndex(of: cat) else { return }
        view?.setFavorite(favorite, at: IndexPath(row: index, section: 0))
    }
}
