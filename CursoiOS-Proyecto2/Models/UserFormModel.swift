//
//  UserFormModel.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 25/1/22.
//

import Foundation

struct UserFormModel {
    var name: String?
    var lastName: String?
    var phone: String?
    var mail: String?
    var bio: String?
}

extension UserFormModel {
    var isValidName: Bool {
        return validate(field: name)
    }
    
    var isValidLastName: Bool {
        return validate(field: lastName)
    }
    
    var isValidPhone: Bool {
        return validate(field: phone)
    }
    
    var isValidMail: Bool {
        return validate(field: mail)
    }
    
    var isValid: Bool {
        return isValidName && isValidLastName && isValidPhone && isValidMail
    }
}

private extension UserFormModel {
    func validate(field: String?) -> Bool {
        guard let field = field else {
            return false
        }
        return !field.isEmpty
    }
}
