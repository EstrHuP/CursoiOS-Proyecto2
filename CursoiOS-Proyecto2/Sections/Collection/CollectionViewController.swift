//
//  CollectionViewController.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 19/1/22.
//

import UIKit

class CollectionViewController: UIViewController {

    static func createFromStoryboard() -> CollectionViewController {
        return UIStoryboard(name: "CollectionViewController", bundle: .main).instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
