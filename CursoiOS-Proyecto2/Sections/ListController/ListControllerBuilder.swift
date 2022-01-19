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
        //caso de uso. Inyección de dependencias
        viewController.fetchLandmarks = FetchLandmarksFromDisk()
        viewController.detailBuilder = DetailControllerBuilder()
        return viewController
    }
}
