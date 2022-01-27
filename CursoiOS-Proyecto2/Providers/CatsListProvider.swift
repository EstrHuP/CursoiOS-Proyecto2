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
    var cats = [Cat]()
    
    private let session: Session
    private let bundle: Bundle
    
    init(session: Session = .default, bundle: Bundle = .main) {
        self.session = session
        self.bundle = bundle
    }
    
    func getCatsList(_ completion: @escaping (Result<[Cat], CatsListProviderError>) -> ()) {
        let url = Bundle.main.baseAPIUrl.appendingPathComponent("api/cats")
        
        let request = URLRequest(url: url)
        session.request(request).responseDecodable { [weak self] (response: DataResponse<[Cat], AFError>) in
            switch response.result {
            case .success(let cats):
                self?.cats = cats
                completion(.success(cats))
            case .failure(let error): completion(.failure(.generic(error)))
            }
        }.validate()
    }
    
    deinit {
        print("deinit\(self)")
    }
}
