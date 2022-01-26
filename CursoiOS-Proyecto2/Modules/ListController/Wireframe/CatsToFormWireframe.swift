//
//  CatsToFormWireframe.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 26/1/22.
//

import Foundation
import UIKit

class CatsToFormWireframe: CatListWireframeContract {
    var view: UIViewController?
    
    //PONER SIEMPRE EL HILO EN LAS NAVEGACIONES
    func navigate(to cat: Cat) {
        DispatchQueue.main.async {
            let detail = UserFormBuilder().build()
            if let navigationController = self.view?.navigationController {
                navigationController.pushViewController(detail, animated: true)
            } else {
                self.view?.present(detail, animated: true)
            }
        }
    }
}
