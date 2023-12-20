import Foundation
@testable import MainPage

final class MockFetchMainPageBusinessLogic: FetchMainPageBusinessLogicProtocol {
    
    var result: Result<MainPageDomainModel, MaingPageErrorModel>?
    
    func fetch(completion: @escaping (Result<MainPageDomainModel, MaingPageErrorModel>) -> Void) {
        guard let result else { return }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion(result)
        }
    }
    
}
