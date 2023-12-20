import Foundation
import Core

final class FetchMainPageBusinessLogic: FetchMainPageBusinessLogicProtocol {
    
    private let url = "https://raw.githubusercontent.com/ofarukcelik/thecodebaseio/master/test-case"
    
    private var networkManager: NetworkManagerProtocol!
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetch(completion: @escaping (Result<MainPageDomainModel, MaingPageErrorModel>) -> Void) {
        networkManager.request(url: url) { (result: Result<MainPageDTOModel, HttpError>) in
            switch result {
            case .success(let data):
                completion(.success(data.convertToMainPageDomainModel()))
            case .failure(_):
                let mainPageError = MaingPageErrorModel(title: "Oops!", desription: "Something Happened, Pls Try Again")
                completion(.failure(mainPageError))
            }
        }
    }
    
}
