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
    
    func configure(with viewModel: UserFormViewModel)
    
    func didValidateName(_ valid: Bool)
    func didValidateLastName(_ valid: Bool)
    func didValidatePhone(_ valid: Bool)
    func didValidateMail(_ valid: Bool)
    
    func showValidationError()
}

protocol UserFormPresenterContract {
    var view: UserFormViewContract? {get set}
    
    func didLoad()
    
    func didUpdateName(_ name: String?)
    func didUpdateLastName(_ lasName: String?)
    func didUpdatePhone(_ phone: String?)
    func didUpdateMail(_ mail: String?)
    func didUpdateBio(_ bio: String?)
    
    func didPressEnd()
}
