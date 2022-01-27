//
//  PermissionsViewController.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 27/1/22.
//

import UIKit

protocol PermissionsPresenterContract {
    var view: PermissionsViewContract? {get set}
    func didPressPermisionsButton()
}

class PermissionsViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
    }
    
    var presenter: PermissionsPresenterContract?
    
    @IBAction func buttonPressed(_ sender: Any) {
        presenter?.didPressPermisionsButton()
    }
}

extension PermissionsViewController: PermissionsViewContract {
    func setAllowed() {
        DispatchQueue.main.async {
            self.button.isEnabled = false
            self.label.text = "Permitido"
        }
    }
    
    func setNotAllowed() {
        DispatchQueue.main.async {
            self.button.isEnabled = true
            self.label.text = "No permitido"
        }
    }
    
    func openSettings() {
        DispatchQueue.main.async {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!) //abrir aplicaciones y urls externas
        }
    }
    
}
