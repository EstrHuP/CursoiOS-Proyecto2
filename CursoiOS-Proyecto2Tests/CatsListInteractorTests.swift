//
//  CatsListInteractorTests.swift
//  CursoiOS-Proyecto2Tests
//
//  Created by Esther Huecas on 27/1/22.
//

import XCTest
@testable import CursoiOS_Proyecto2

class CatsListInteractorTests: XCTestCase {
    
    class MockCatsProvider: CatsListProviderContract {
        let cats: [Cat] = [
            .init(id: "1", created_at: "2020", tags: ["cute", "one"]),
            .init(id: "2", created_at: "120", tags: ["ugly"])
        ]
        
        var shouldFail = false
        
        func getCatsList(_ completion: @escaping (Result<[Cat], CatsListProviderError>) -> ()) {
            if shouldFail {
                completion(.failure(.badUrl))
            } else {
                completion(.success(cats))
            }
        }
    }
    
    class MockedListInteractorOutput: ListInteractorOutputContract {
        let expectation: XCTestExpectation
        
        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }
        
        var cats = [Cat]()
        var didFail = false
        
        func didFetch(cats: [Cat]) {
            self.cats = cats
            expectation.fulfill()
        }
        
        func fetchDidFail() {
            didFail = true
            expectation.fulfill()
        }
        
        func didUpdateFavorites(in cat: Cat, favorite: Bool) {
            
        }
    }

    func testShouldFetchCats() {
        let expectation = expectation(description: "")
        
        let output = MockedListInteractorOutput(expectation: expectation)
        let provider = MockCatsProvider()
        let sut = CatsListInteractor()
        
        sut.catsProvider = provider
        sut.output = output
        sut.fetchItems()
        
        waitForExpectations(timeout: 0.5) { _ in
            XCTAssertEqual(output.cats, provider.cats)
        }
    }
    
    func testShouldNotifyOnFail() {
        let expectation = expectation(description: "")
        
        let output = MockedListInteractorOutput(expectation: expectation)
        let provider = MockCatsProvider()
        let sut = CatsListInteractor()
        
        sut.catsProvider = provider
        sut.output = output
        sut.fetchItems()
        
        waitForExpectations(timeout: 0.5) { _ in
            XCTAssertTrue(output.didFail)
        }
    }
}
