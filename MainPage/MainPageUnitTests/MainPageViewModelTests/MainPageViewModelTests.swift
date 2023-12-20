import XCTest
@testable import MainPage

final class MainPageViewModelTests: XCTestCase {
    
    var sut: MainPageViewModel!
    var mockFetchMainPageBusinessLogic: MockFetchMainPageBusinessLogic!
    var delegateHandler: MainPageViewModelDelegateHandler!

    var mockData = MainPageDomainModel(
        owner: .init(name: "Ali", surname: "Veli", profileImage: ""),
        cards: [
            .init(
                type: .realEstate, id: 0, title: "Beylikdüzü Muhteşem konumda Görülmeye Değer ev", city: "İzmir", district: "Karşıyka", price: 1500, currency: "₺",
                badges: ["Yeni", "Krediye Uygun"], images: ["", ""], name: nil, surname: nil, registerDate: nil, profileImage: nil
            ),
            .init(
                type: .clothing, id: 1, title: "Nike Sport Sarı Kombinim Hiç bir defosu yok tekliflere açığım", city: nil, district: nil, price: 1500, currency: "₺",
                badges: ["Yeni", "Krediye Uygun"], images: ["", ""], name: nil, surname: nil, registerDate: nil, profileImage: nil
            ),
            .init(
                type: .favoriteSeller, id: 2, title: nil, city: nil, district: nil, price: nil, currency: nil,
                badges: nil, images: nil, name: "Sevgi", surname: "Ölmez", registerDate: "12.01.2023", profileImage: ""
            )
        ]
    )
    
    var errorModel = MaingPageErrorModel(title: "Oops!", desription: "Something happened, pls try again.")
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockFetchMainPageBusinessLogic = MockFetchMainPageBusinessLogic()
        delegateHandler = MainPageViewModelDelegateHandler()
        sut = MainPageViewModel(fetchMainPageBusinessLogic: mockFetchMainPageBusinessLogic)
        sut.delegate = delegateHandler
    }

    override func tearDownWithError() throws {
        sut = nil
        mockFetchMainPageBusinessLogic = nil
        delegateHandler = nil
        
        try super.tearDownWithError()
    }
    
    func test_Success_GetData() throws {
        mockFetchMainPageBusinessLogic.result = .success(mockData)
        
        let expectation = expectation(description: "getDataWithSuccessResponse")
        
        sut.getMainPage()
        
        XCTAssertEqual(sut.state, .loading)
        XCTAssertEqual(delegateHandler.currentState, .loading)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.sut.state, .list)
            XCTAssertEqual(self.delegateHandler.currentState, .list)
            XCTAssertNotNil(self.sut.mainPageModel)
            XCTAssertTrue(self.sut.filterCardModels.count != 0)
            XCTAssertEqual(self.sut.mainPageModel?.owner.name, self.mockData.owner.name)
            XCTAssertEqual(self.sut.filterCardModels.first?.id, self.mockData.cards.first?.id)
            XCTAssertEqual(self.sut.filterCardModels.first?.type, self.mockData.cards.first?.type)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_Error_GetErrorModel() throws {
        mockFetchMainPageBusinessLogic.result = .failure(errorModel)
        
        let expectation = expectation(description: "getErrorModelWithFailureResponse")
        
        sut.getMainPage()
        
        XCTAssertEqual(sut.state, .loading)
        XCTAssertEqual(delegateHandler.currentState, .loading)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.sut.state, .error(self.errorModel))
            XCTAssertEqual(self.delegateHandler.currentState, .error(self.errorModel))
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_FilterSuccess() throws {
        sut.mainPageModel = mockData
        sut.filterCardModels = mockData.cards
        
        sut.filter(forType: .clothing)
        
        XCTAssertTrue(sut.filterCardModels.count == 1)
        XCTAssertTrue(sut.filterCardModels.contains(where: { $0.type == .clothing }))
        XCTAssertFalse(sut.filterCardModels.contains(where: { $0.type == .realEstate }))
        XCTAssertFalse(sut.filterCardModels.contains(where: { $0.type == .favoriteSeller }))
    }
    
    func test_FilterWithAllOptionShouldFillFilterArrayWithWholeData() {
        sut.mainPageModel = mockData
        sut.filterCardModels = [
            .init(
                type: .clothing, id: 1, title: "Nike Sport Sarı Kombinim Hiç bir defosu yok tekliflere açığım", city: nil, district: nil, price: 1500, currency: "₺",
                badges: ["Yeni", "Krediye Uygun"], images: ["", ""], name: nil, surname: nil, registerDate: nil, profileImage: nil
            )
        ]
        
        sut.filter(forType: .all)
        
        XCTAssertTrue(sut.filterCardModels.count == 3)
        XCTAssertTrue(sut.filterCardModels.contains(where: { $0.type == .realEstate }))
        XCTAssertTrue(sut.filterCardModels.contains(where: { $0.type == .favoriteSeller }))
        XCTAssertTrue(sut.filterCardModels.contains(where: { $0.type == .clothing }))
    }
    
    func test_StateUpdateWorksWhenReplacingWithSameState() throws {
        sut.mainPageModel = mockData
        sut.filterCardModels = mockData.cards
        sut.state = .list
        
        sut.filter(forType: .clothing)
        
        XCTAssertTrue(delegateHandler.stateUpdateCount == 2)
    }

}
