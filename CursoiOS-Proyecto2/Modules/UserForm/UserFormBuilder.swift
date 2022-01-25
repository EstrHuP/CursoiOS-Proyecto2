//
//  UserFormBuilder.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 25/1/22.
//

import Foundation
import UIKit

class UserFormBuilder {
    func build() -> UIViewController {
        let viewController = UserFormViewController.createFromStoryboard()
        return viewController
    }
}
