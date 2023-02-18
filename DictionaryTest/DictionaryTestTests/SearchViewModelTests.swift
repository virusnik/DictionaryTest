//
//  SearchViewModelTests.swift
//  DictionaryTestTests
//
//  Created by Sergio Veliz on 12.02.2023.
//

import XCTest
import Combine
@testable import DictionaryTest

final class SearchViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    var viewModel: SearchViewModel!
    var serviceMock: WordsSearchServiceMock!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        serviceMock = WordsSearchServiceMock()
        viewModel = SearchViewModel(service: serviceMock)
    }

    override func tearDownWithError() throws {
        serviceMock = nil
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testWordsServiceMock() async {
        let serviceMock = WordsSearchServiceMock()
        let failingResult = await serviceMock.getWordMeaningsFailere(searchText: "")
        
        switch failingResult {
        case .success(let words):
            XCTAssertEqual(words.first?.text, "king")
        case .failure(let error):
            XCTAssertEqual(error, .unknown)
        }
    }
    
    func testMainViewControllerFetchData() async throws {
        let viewModel = SearchViewModel(service: WordsSearchServiceMock())
        
        let expectation = expectation(description: "Fetch data from service")
        
        viewModel.getWord(searchText: "king")
        
        viewModel.$state.dropFirst().sink { state in
            XCTAssertEqual(state, .finishedLoading)
            expectation.fulfill()
            
        }.store(in: &cancellables)
        
        await waitForExpectations(timeout: 3.0, handler: nil)
        
        XCTAssertEqual(viewModel.words.count, 15)
        XCTAssertEqual(viewModel.words.first?.text, "king")
    }
    
}
