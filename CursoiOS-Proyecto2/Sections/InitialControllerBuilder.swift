//
//  InitialControllerBuilder.swift
//  CursoiOS-Proyecto2
//
//  Created by Miguel Santiago on 19/1/22.
//

import Foundation
import UIKit

class InitialControllerBuilder {
    func build() -> UIViewController {
        let tabBarController = UITabBarController()
        let viewControllers = [buildList(), buildCollection()]
        tabBarController.setViewControllers(viewControllers, animated: false)
        
        return tabBarController
    }
}

private extension InitialControllerBuilder {
    func buildList() -> UINavigationController {
        let viewController = ListControllerBuilder().build()
        let tabBarItem = UITabBarItem(title: "List", image: .init(systemName: "list.bullet"), tag: 0)
        
        return buildNavigation(with: viewController, tabBarItem: tabBarItem)
    }
    
    func buildCollection() -> UINavigationController {
        let collectionController = CollectionControllerBuilder().build()
        let collectionNavigation = UITabBarItem(title: "Collection", image: .init(systemName: "list.bullet"), tag: 1)
        
        return buildNavigation(with: collectionController, tabBarItem: collectionNavigation)
    }
    
    func buildNavigation(with viewController: UIViewController, tabBarItem: UITabBarItem) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = tabBarItem
        
        return navigationController
    }
}
