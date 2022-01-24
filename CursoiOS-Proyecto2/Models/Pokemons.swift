//
//  Pokemons.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 24/1/22.
//

import Foundation
import Alamofire

struct PokemonResult: Codable {
    let name: String
    let url: String
}

struct PokemonResponse: Codable {
    let count: Int
    let results: [PokemonResult]
}

class FetchPokemon {
    func fetch(_ completion: @escaping ([PokemonResult]) -> ()) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        AF.request(url).responseDecodable { (result: DataResponse<PokemonResponse, AFError>) in
            switch result.result {
            case .success(let response): completion(response.results)
            case .failure: completion([])
            }
        }
    }
}
