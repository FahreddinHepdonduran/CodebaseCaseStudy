import Foundation
import Core
@testable import MainPage

final class MockNetworkManager: NetworkManagerProtocol {
    
    var result: Result<MainPageDTOModel, HttpError>?
    
    func request<T: Codable>(url: String, completion: @escaping (Result<T, HttpError>) -> Void) {
        guard let result = result as? Result<T, HttpError> else {
            return
        }
        
        completion(result)
    }
    
}
