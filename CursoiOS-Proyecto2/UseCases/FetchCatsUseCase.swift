//
//  FetchCatsUseCase.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 20/1/22.
//

import Foundation

protocol FetchCatsUseCase {
    //Llamar a una func dentro de otra
    func fetchCats(completion: @escaping ([Cat]) -> Void)
}

class FetchCatsFromAPI: FetchCatsUseCase {
    func fetchCats(completion: @escaping ([Cat]) -> Void) {
        guard let url = URL(string: "https://cataas.com/api/cats") else {
            completion([])
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let cats = try JSONDecoder().decode([Cat].self, from: data)
                completion(cats)
            } catch {
                completion([])
            }
        }.resume()
    }
}
