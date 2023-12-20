import XCTest
import Core
@testable import MainPage

final class FetchMainPageBusinessLogicTests: XCTestCase {

    var sut: FetchMainPageBusinessLogic!
    var mockNetworkManager: MockNetworkManager!
    
    var mockSuccessResponseModel: MainPageDTOModel = .init(
        owner: .init(name: "Ali", surname: "Veli", registerDate: "11/11/2000", profileImage: ""),
        cards: [
            .init(
                type: .realEstate,
                data: .init(
                    id: 0, title: "Beylikdüzü Muhteşem konumda Görülmeye Değer ev", address: .init(city: "izmir", district: "Karşıyaka"),
                    price: 1500, currency: "₺", badges: ["Yeni", "Krediye Uygun"], images: nil,
                    name: nil, surname: nil, registerDate: nil, profileImage: nil
                )
            )
        ]
    )
    
    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        sut = FetchMainPageBusinessLogic(networkManager: mockNetworkManager)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        mockNetworkManager = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_Success_ReturnsData() throws {
        mockNetworkManager.result = .success(mockSuccessResponseModel)
        
        let expectation = XCTestExpectation(description: "getMainPageResponseWhenSuccess")
        
        sut.fetch { [weak self] (result: Result<MainPageDomainModel, MaingPageErrorModel>) in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                XCTAssertEqual(data.owner.name, self.mockSuccessResponseModel.owner.name)
                XCTAssertEqual(data.cards.first?.id, self.mockSuccessResponseModel.cards.first?.data.id)
                // ...
                expectation.fulfill()
            case .failure(let errorModel):
                XCTAssertThrowsError(errorModel)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_Error_ReturnsMainPageErrorModel() throws {
        mockNetworkManager.result = .failure(.badResponse)
        
        let expectation = XCTestExpectation(description: "getMainPageErrorModelWhenError")
        
        sut.fetch { (result: Result<MainPageDomainModel, MaingPageErrorModel>) in
            switch result {
            case .success(_):
                XCTAssertThrowsError(HttpError.badResponse)
            case .failure(let errorModel):
                XCTAssertEqual(errorModel.title, "Oops!")
                XCTAssertEqual(errorModel.desription, "Something Happened, Pls Try Again")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }

}
