//
//  DetailControllerBuilder.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 19/1/22.
//

import Foundation
import UIKit

class DetailControllerBuilder {
    func build(viewModel: DetailViewModel) -> UIViewController {
        let detailViewController = DetailViewController.createFromXib()
        detailViewController.viewModel = viewModel
        return detailViewController
    }
}
