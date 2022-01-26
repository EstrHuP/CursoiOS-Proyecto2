//
//  UIViewControllerExtensions.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 26/1/22.
//

import Foundation
import UIKit

extension UIViewController {
    static func createFromStoryboard() -> Self {
        return UIStoryboard(name: String(describing: self), bundle: .main).instantiateViewController(withIdentifier: String(describing: self)) as! Self
    }
}
