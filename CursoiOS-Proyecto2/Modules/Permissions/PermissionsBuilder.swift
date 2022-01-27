//
//  PermissionsBuilder.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 27/1/22.
//

import Foundation
import UIKit

class PermissionsBuilder {
    func build() -> UIViewController {
        let viewController = PermissionsViewController.createFromStoryboard()
        viewController.presenter = buildPresenter()
        
        return viewController
    }
    
    func buildForTabBar(tag: Int) -> UIViewController {
        let viewController = build()
        viewController.tabBarItem = .init(title: "permissions", image: nil, tag: tag)
        
        return viewController
    }
}

private extension PermissionsBuilder {
    func buildInteractor() -> PermissionsInteractorContract {
        LocationPermissionInteractor()
    }
    
    func buildPresenter() -> PermissionsPresenterContract {
        PermissionsPresenter(interactor: buildInteractor())
    }
}
