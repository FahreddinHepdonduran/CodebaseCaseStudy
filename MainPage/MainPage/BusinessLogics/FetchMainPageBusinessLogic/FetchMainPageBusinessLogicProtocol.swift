import Foundation

protocol FetchMainPageBusinessLogicProtocol {
    func fetch(completion: @escaping (Result<MainPageDomainModel, MaingPageErrorModel>) -> Void)
}


