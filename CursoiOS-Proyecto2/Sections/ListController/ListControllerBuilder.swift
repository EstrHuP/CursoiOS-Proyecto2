//
//  ListControllerBuilder.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 19/1/22.
//

import Foundation
import UIKit

class ListControllerBuilder {
    
    func build() -> UIViewController {
        let viewController = ListViewController.createFromStoryboard()
        
        //VIPER
        let presenter = CatsListPresenter()
        let interactor = FetchCatsFromAPI()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.fetchCats = interactor
        
        return viewController
    }
}
