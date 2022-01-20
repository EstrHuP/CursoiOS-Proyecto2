//
//  Cat.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 20/1/22.
//

import Foundation

//Codable -> para escribir en disco
//Decodable -> descrifrar json
struct Cat: Decodable {
    let id: String
    let created_at: String
    let tags: [String]
}

extension Cat {
    var tagsText: String {
        return tags.joined(separator: " ,")
    }
    
    var imageUrl: URL? {
        return URL(string: "https://cataas.com/cat/\(id)")
    }
}
