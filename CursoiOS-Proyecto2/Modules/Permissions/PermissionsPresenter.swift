//
//  PermissionsPresenter.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 27/1/22.
//

import Foundation

protocol PermissionsViewContract: AnyObject {
    func setAllowed()
    func setNotAllowed()
    func openSettings()
}

enum PermissionInteractorStatus {
    case allowed, denied, unknown
}

protocol PermissionsInteractorContract: AnyObject {
    var output: PermissionsInteractorOutputContract? {get set}
    var currentPermission: PermissionInteractorStatus {get}
    func askForPermission()
}

protocol PermissionsInteractorOutputContract: AnyObject {
    func didUpdatePermission(status: PermissionInteractorStatus)
}

class PermissionsPresenter {
    private let interactor: PermissionsInteractorContract?
    
    init(interactor: PermissionsInteractorContract?) {
        self.interactor = interactor
    }
    
    weak var view: PermissionsViewContract? {
        didSet {
            guard let status = interactor?.currentPermission else { return }
            interactor?.output = self
            didUpdatePermission(status: status)
        }
    }
}

extension PermissionsPresenter: PermissionsInteractorOutputContract {
    func didUpdatePermission(status: PermissionInteractorStatus) {
        switch status {
        case .allowed: view?.setAllowed()
        case .denied, .unknown: view?.setNotAllowed()
        }
    }
}

extension PermissionsPresenter: PermissionsPresenterContract {
    func didPressPermisionsButton() {
        guard let status = interactor?.currentPermission else { return }
        switch status {
        case .allowed: break
        case .denied: view?.openSettings() //open settings
        case .unknown: interactor?.askForPermission() //pedir permiso
        }
    }
}
