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
    
    func viewDidLoad()
    
    var numItems: Int {get}
    func cellViewModel(at indexPath: IndexPath) -> ListTableCellViewModel
    func isFavorite(at indexPath: IndexPath) -> Bool
    
    func didSelectFavorite(at indexPath: IndexPath)
    func didSelectItem(at indexPath: IndexPath)
}
