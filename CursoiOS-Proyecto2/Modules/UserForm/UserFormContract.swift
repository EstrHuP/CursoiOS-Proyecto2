//
//  UserFormContract.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 25/1/22.
//

import Foundation
import UIKit

protocol UserFormViewContract: UIViewController {
    var presenter: UserFormPresenterContract? {get set}
}

protocol UserFormPresenterContract {
    var view: UserFormViewContract? {get set}
    
    func didUpdateName(_ name: String?)
    func didUpdateLastName(_ lasName: String?)
    func didUpdatePhone(_ phone: String?)
    func didUpdateMail(_ mail: String?)
}
