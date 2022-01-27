//
//  BundleExtensions.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 27/1/22.
//

import Foundation

extension Bundle {
    var baseAPIUrl: URL {
        guard let urlString = infoDictionary?["API_BASE_URL"] as? String else {
            fatalError("Invalid Base URL")
        }
        return URL(string: urlString)!
    }
}
