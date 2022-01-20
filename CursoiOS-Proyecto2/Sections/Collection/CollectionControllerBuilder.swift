//
//  CollectionControllerBuilder.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 19/1/22.
//

import Foundation
import UIKit

class CollectionControllerBuilder {
    func build() -> UIViewController {
        let collectionViewController = CollectionViewController.createFromStoryboard()
        collectionViewController.fetchLandmarks = FetchLandmarksFromDisk()
        collectionViewController.detailBuilder = DetailControllerBuilder()
        
        return collectionViewController
    }
}
