//
//  UsersViewModelTests.swift
//  UnitTesting
//

@testable import UnitTesting
import XCTest

class UsersViewModelTests: XCTestCase {
    var mockService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
    }
    
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }
    
    // assert that sut.fetchUsers(completion: {}) calls appropriate method of api service
    // use XCAssertEqual, fetchUsersCallsCount
    func test_viewModel_whenFetchUsers_callsApiService() {
        let sut = makeSut()
        
        sut.fetchUsers { }
        
        XCTAssert(mockService.fetchUsersCallsCount == 1)
    }

    // assert that the passed url to api service is correct
    func test_viewModel_whenFetchUsers_passesCorrectUrlToApiService() {
        let sut = makeSut()
        let validURL = "https://jsonplaceholder.typicode.com/users"
        
        sut.fetchUsers { }
        
        XCTAssertEqual(mockService.lastURLString, validURL)
    }

    // assert that view model users are updated and error message is nil
    func test_viewModel_fetchUsers_whenSuccess_updatesUsers() {
        mockService.fetchUsersResult = .success(
            [User(id: 1, name: "name", username: "surname", email: "user@email.com")]
        )
        let sut = makeSut()
        let expectedResult = expectation(description: "fetch with success")
        
        sut.fetchUsers { expectedResult.fulfill() }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(sut.users.count, 1)
        
        XCTAssertEqual(sut.users[0].id, 1)
        XCTAssertEqual(sut.users[0].name, "name")
        XCTAssertEqual(sut.users[0].username, "surname")
        XCTAssertEqual(sut.users[0].email, "user@email.com")
        
        XCTAssertNil(sut.errorMessage)
    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenInvalidUrl_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.invalidUrl)
        let sut = makeSut()
        let expectedResult = expectation(description: "fetch with error")
        
        sut.fetchUsers { expectedResult.fulfill() }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(sut.errorMessage, "Unexpected error")
        XCTAssertTrue(sut.users.isEmpty)
    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenUnexectedFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.unexpected)
        let sut = makeSut()
        let expectedResult = expectation(description: "fetch with error")
        
        sut.fetchUsers { expectedResult.fulfill() }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertTrue(sut.users.isEmpty)
        XCTAssertEqual(sut.errorMessage, "Unexpected error")
    }

    // assert that view model error message is "Error parsing JSON"
    func test_viewModel_fetchUsers_whenParsingFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.parsingError)
        let sut = makeSut()
        let expectedResult = expectation(description: "fetch with error")
        
        sut.fetchUsers { expectedResult.fulfill() }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertTrue(sut.users.isEmpty)
        XCTAssertEqual(sut.errorMessage, "Error parsing JSON")
    }

    // fetch users with successful result and after calling clear() assert users are empty
    func test_viewModel_clearUsers() {
        mockService.fetchUsersResult = .success(
            [User(id: 1, name: "name", username: "surname", email: "user@email.com")]
        )
        let sut = makeSut()
        let expectedResult = expectation(description: "fetch with success")
        
        sut.fetchUsers { expectedResult.fulfill()}
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(sut.users.count, 1)
        
        sut.clearUsers()
        XCTAssertTrue(sut.users.isEmpty)
    }

    private func makeSut() -> UsersViewModel {
        UsersViewModel(apiService: mockService)
    }
}
