//
//  UserFormViewController.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 25/1/22.
//

import UIKit

class UserFormViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static func createFromStoryboard() -> UserFormViewController {
        return UIStoryboard(name: "UserFormViewController", bundle: .main).instantiateViewController(withIdentifier: "UserFormViewController") as! UserFormViewController
    }

}
