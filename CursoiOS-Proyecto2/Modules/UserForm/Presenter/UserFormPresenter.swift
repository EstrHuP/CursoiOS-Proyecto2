//
//  UserFormPresenter.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 25/1/22.
//

import Foundation

class UserFormPresenter: UserFormPresenterContract {
    weak var view: UserFormViewContract?
    
    private let fileManager: FileManager
    private let fileName: String
    
    //TODO: el fileManager (persistencia de datos) va en el interactor
    //siempre que se use un filemanager se usa el default.
    //encargado de guardar y leer del disco
    init(fileManager: FileManager = FileManager.default, fileName: String = "userData") {
        self.fileManager = fileManager
        self.fileName = fileName
    }
    
    private var fileUrl: URL? {
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(fileName).plist")
        print(url)
        return url
    }
    
    func didLoad() {
        fetchUser()
    }
    
    private var userFormModel = UserFormModel(name: nil, lastName: nil, phone: nil, mail: nil, bio: nil) {
        didSet {
            print(userFormModel)
        }
    }
    
    func didUpdateName(_ name: String?) {
        userFormModel.name = name
        view?.didValidateName(userFormModel.isValidName)
    }
    
    func didUpdateLastName(_ lasName: String?) {
        userFormModel.lastName = lasName
        view?.didValidateLastName(userFormModel.isValidLastName)
    }
    
    func didUpdatePhone(_ phone: String?) {
        userFormModel.phone = phone
        view?.didValidatePhone(userFormModel.isValidPhone)
    }
    
    func didUpdateMail(_ mail: String?) {
        userFormModel.mail = mail
        view?.didValidateMail(userFormModel.isValidMail)
    }
    
    func didUpdateBio(_ bio: String?) {
        userFormModel.bio = bio
    }
    
    func didPressEnd() {
        guard userFormModel.isValid else {
            view?.showValidationError()
            return
        }
        saveUser(userFormModel)
        print("success")
    }
    
    //MARK: Gestion de memoria
    deinit {
        print("deinit \(self)")
    }
}

private extension UserFormPresenter {
    private func fetchUser() {
        loadUser { user in
            guard let user = user else { return }
            self.userFormModel = user
            self.view?.configure(with: UserFormViewModel(name: user.name, lastName: user.lastName, phone: user.phone, mail: user.mail, bio: user.bio)) //esto se puede inicializar desde el modelo
        }
    }
    
    func saveUser(_ user: UserFormModel) {
        guard let url = fileUrl else {
            return
        }
        
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(user)
            try data.write(to: url)
        } catch {
            
        }
    }
    
    func loadUser(_ completion: @escaping (UserFormModel?) -> ()) {
        DispatchQueue.global().async {
            guard let url = self.fileUrl else {
                completion(nil)
                return
            }
            
            guard let data = try? Data(contentsOf: url) else {
                completion(nil)
                return
            }
            do {
                let user = try PropertyListDecoder().decode(UserFormModel.self, from: data)
                completion(user)
            } catch {
                
            }
        }
    }
}
