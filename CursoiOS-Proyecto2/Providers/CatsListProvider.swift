//
//  CatsListProvider.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 25/1/22.
//

import Foundation
import Alamofire

enum CatsListProviderError: Error {
    case badUrl
    case generic(Error?)
}

protocol CatsListProviderContract {
    func getCatsList(_ completion: @escaping (Result<[Cat], CatsListProviderError>) -> ())
}

class NetworkCatsListProvider: CatsListProviderContract {
    func getCatsList(_ completion: @escaping (Result<[Cat], CatsListProviderError>) -> ()) {
        guard let url = URL(string: "https://cataas.com/api/cats") else {
            completion(.failure(.badUrl))
            return
        }
        
        let request = URLRequest(url: url)
        AF.request(request).responseDecodable { (response: DataResponse<[Cat], AFError>) in
            switch response.result {
            case .success(let cats): completion(.success(cats))
            case .failure(let error): completion(.failure(.generic(error)))
            }
        }.validate()
    }
}
