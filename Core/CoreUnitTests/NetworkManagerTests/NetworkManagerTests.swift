import XCTest
@testable import Core

final class NetworkManagerTests: XCTestCase {
    
    var session: URLSession!
    var sut: NetworkManagerProtocol!
        
    let urlStr = "https://api.thecatapi.com/v1/images/search"
    let url = URL(string: "https://api.thecatapi.com/v1/images/search")!
    
    let mockString =
            """
                {
                    "cats": [
                        {
                            "id": "8on",
                            "url": "https://cdn2.thecatapi.com/images/8on.jpg",
                        }
                    ]
                }
            """

    override func setUpWithError() throws {
        try super.setUpWithError()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        sut = NetworkManager(session: session)
    }

    override func tearDownWithError() throws {
        session = nil
        sut = nil
        
        try super.tearDownWithError()
    }
    
    func test_Success_GetData() throws {
        let response = HTTPURLResponse(
            url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"]
        )!
        
        let mockData = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "successGetDta")
        
        sut.request(url: urlStr) { (result: Result<MockModel, HttpError>) in
            switch result {
            case .success(let mockModel):
                XCTAssertEqual(mockModel.cats.first?.url, "https://cdn2.thecatapi.com/images/8on.jpg")
                XCTAssertEqual(mockModel.cats.count, 1)
                
                expectation.fulfill()
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_Success_DecodingError() throws {
        let response = HTTPURLResponse(
            url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"]
        )!
        
        let mockData = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "success_NotMatchingKeys_GetDecodingError")
        
        sut.request(url: urlStr) { (result: Result<NotMatchingKeysMockModel, HttpError>) in
            switch result {
            case .success(_):
                XCTAssertThrowsError("Fatal Error")
            case .failure(let error):
                XCTAssertEqual(error, HttpError.errorDecodingData)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_Error_BadReuest() throws {
        let response = HTTPURLResponse(
            url: url, statusCode: 400, httpVersion: nil, headerFields: ["Content-Type": "application/json"]
        )!
        
        let mockData = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "errorBadRequest")
        
        sut.request(url: urlStr) { (result: Result<NotMatchingKeysMockModel, HttpError>) in
            switch result {
            case .success(_):
                XCTAssertThrowsError("Fatal Error")
            case .failure(let error):
                XCTAssertEqual(error, HttpError.badResponse)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_Error_InvalidUrl() throws {
        let response = HTTPURLResponse(
            url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"]
        )!
        
        let mockData = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "errorInvalidUrl")
        
        sut.request(url: "") { (result: Result<NotMatchingKeysMockModel, HttpError>) in
            switch result {
            case .success(_):
                XCTAssertThrowsError("Fatal Error")
            case .failure(let error):
                XCTAssertEqual(error, HttpError.invalidURL)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2)
    }

}
