//
//  APIServiceTests.swift
//  UnitTesting
//

import XCTest
@testable import UnitTesting

final class APIServiceTests: XCTestCase {
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
    }
    
    override func tearDown() {
        mockURLSession = nil
        super.tearDown()
    }
    
    // MARK: Fetch Users

    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    // use expectations
    func test_apiService_fetchUsers_whenInvalidUrl_completesWithError() {
        let sut = makeSut()
        let expectedResult = expectation(description: "invalidUrl error thrown")
        let invalidURL = ""
        
        sut.fetchUsers(urlString: invalidURL) { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, .invalidUrl)
            case .success: XCTFail("expected invalidUrl error, got success")
            }
            
            expectedResult.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }

    // assert that method completes with .success(expectedUsers)
    func test_apiService_fetchUsers_whenValidSuccessfulResponse_completesWithSuccess() {
        let response = """
        [
            { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "username": "janedoe", "email": "janedoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        let sut = makeSut()
        let validURL = "valid_url.com"
        
        sut.fetchUsers(urlString: validURL) { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users[0].id, 1)
                XCTAssertEqual(users[0].name, "John Doe")
                XCTAssertEqual(users[0].username, "johndoe")
                XCTAssertEqual(users[0].email, "johndoe@gmail.com")
                               
                XCTAssertEqual(users[1].id, 2)
                XCTAssertEqual(users[1].name, "Jane Doe")
                XCTAssertEqual(users[1].username, "janedoe")
                XCTAssertEqual(users[1].email, "janedoe@gmail.com")
            case .failure(let error):
                XCTFail("expected success, got error \(error)")
            }
        }
    }

    // assert that method completes with .failure(.parsingError)
    func test_apiService_fetchUsers_whenInvalidSuccessfulResponse_completesWithFailure() {
        mockURLSession.mockData = "error json".data(using: .utf8)
        let sut = makeSut()
        let validURL = "valid_url.com"
        
        sut.fetchUsers(urlString: validURL) { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, .parsingError)
            case .success: XCTFail("expected parsingError, got success")
            }
        }
    }

    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsers_whenError_completesWithFailure() {
        mockURLSession.mockData = nil
        let sut = makeSut()
        let validURL = "valid_url.com"
        
        sut.fetchUsers(urlString: validURL) { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, .unexpected)
            case .success: XCTFail("expected unexpected, got success")
            }
        }
    }

    // MARK: Fetch Users Async

    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    func test_apiService_fetchUsersAsync_whenInvalidUrl_completesWithError() async {
        let sut = makeSut()
        let invalidURL = ""
        
        let result = await sut.fetchUsersAsync(urlString: invalidURL)
        
        switch result {
        case .failure(let error): XCTAssertEqual(error, .invalidUrl)
        case .success: XCTFail("expected invalidUrl, got success")
        }
    }

    func test_apiService_fetchUsersAsync_whenValidSuccessfulResponse_completesWithSuccess() async {
        let response = """
        [
            { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "username": "janedoe", "email": "janedoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        let sut = makeSut()
        let validURL = "valid_url.com"
        
        let result = await sut.fetchUsersAsync(urlString: validURL)
        
        switch result {
        case .success(let users):
            XCTAssertEqual(users[0].id, 1)
            XCTAssertEqual(users[0].name, "John Doe")
            XCTAssertEqual(users[0].username, "johndoe")
            XCTAssertEqual(users[0].email, "johndoe@gmail.com")
            
            XCTAssertEqual(users[1].id, 2)
            XCTAssertEqual(users[1].name, "Jane Doe")
            XCTAssertEqual(users[1].username, "janedoe")
            XCTAssertEqual(users[1].email, "janedoe@gmail.com")
        case .failure(let error):
            XCTFail("expected success, got error \(error)")
        }
    }
    
    func test_apiService_fetchUsersAsync_whenInvalidSuccessfulResponse_completesWithFailure() async {
        mockURLSession.mockData = "error json".data(using: .utf8)
        let sut = makeSut()
        let validURL = "valid_url.com"
        
        let result = await sut.fetchUsersAsync(urlString: validURL)
        
        switch result {
        case .failure(let error): XCTAssertEqual(error, .parsingError)
        case .success: XCTFail("expected parsingError, got success")
        }
    }
    
    func test_apiService_fetchUsersAsync_whenError_completesWithFailure() async {
        mockURLSession.mockData = nil
        let sut = makeSut()
        let validURL = "valid_url.com"
        
        let result = await sut.fetchUsersAsync(urlString: validURL)
        
        switch result {
        case .failure(let error): XCTAssertEqual(error, .unexpected)
        case .success: XCTFail("expected unexpected, got success")
        }
    }
    
    func test_apiService_fetchUsersAsync_whenError_completesWithUnexpected() async {
        mockURLSession.mockError = NSError(domain: "test", code: 123, userInfo: nil)
        mockURLSession.mockData = nil
        let sut = makeSut()
        let validURL = "valid_url.com"
        
        let result = await sut.fetchUsersAsync(urlString: validURL)
        
        switch result {
        case .failure(let error): XCTAssertEqual(error, .unexpected)
        case .success: XCTFail("expected unexpected, got success")
        }
    }

    private func makeSut() -> APIService {
        APIService(urlSession: mockURLSession)
    }
}
