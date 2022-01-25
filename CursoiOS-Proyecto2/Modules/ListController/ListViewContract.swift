//
//  ListViewContract.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 24/1/22.
//

import Foundation
import UIKit

protocol ListViewContract: UIViewController { //vista hacia el presenter
    var presenter: ListPresenterContract? {set get}
    
    func reloadData()
    func setFavorite(_ favorite: Bool, at indexPath: IndexPath)
}

protocol ListPresenterContract: AnyObject { //presenter hacia la vista
    var view: ListViewContract? {get set}
    var interactor: ListInteractorContract? {get set}
    var wireframe: CatListWireframeContract? {get set}
    
    func viewDidLoad()
    
    var numItems: Int {get}
    func cellViewModel(at indexPath: IndexPath) -> ListTableCellViewModel
    func isFavorite(at indexPath: IndexPath) -> Bool
    
    func didSelectFavorite(at indexPath: IndexPath)
    func didSelectItem(at indexPath: IndexPath)
}

protocol ListInteractorContract {
    var catsProvider: CatsListProviderContract? {get set}
    var output: ListInteractorOutputContract? {get set}
    func fetchItems()
    func didPressFavorite(in cat: Cat)
    func isFavorite(cat: Cat) -> Bool
}

protocol ListInteractorOutputContract {
    func didFetch(cats: [Cat])
    func fetchDidFail()
    func didUpdateFavorites(in cat: Cat, favorite: Bool)
}

//SOLO SE USA WIREFRAME/ROUTER EN EL CASO DE QUE SE VAYA A NAVEGAR A OTRA PANTALLA
protocol CatListWireframeContract {
    var view: UIViewController? {get set}
    func navigate(to cat: Cat)
}
