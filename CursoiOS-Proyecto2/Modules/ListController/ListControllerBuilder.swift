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
        let interactor = CatsListInteractor()
        interactor.catsProvider = NetworkCatsListProvider()
        
        let wireframe = CatsListWireframe()
//        let wireframe = CatsToFormWireframe()
//        let wireframe = CatsToCatsWireframe()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        wireframe.view = viewController
        
        return viewController
    }
}
