//
//  UserFormPresenter.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 25/1/22.
//

import Foundation

class UserFormPresenter: UserFormPresenterContract {
    var view: UserFormViewContract?
    
    private var userFormModel = UserFormModel(name: nil, lastName: nil, phone: nil, mail: nil) {
        didSet {
            print(userFormModel)
        }
    }
    
    func didUpdateName(_ name: String?) {
        userFormModel.name = name
    }
    
    func didUpdateLastName(_ lasName: String?) {
        userFormModel.lastName
    }
    
    func didUpdatePhone(_ phone: String?) {
        userFormModel.phone
    }
    
    func didUpdateMail(_ mail: String?) {
        userFormModel.mail
    }
}
