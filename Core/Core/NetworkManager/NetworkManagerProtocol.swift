import Foundation

public protocol NetworkManagerProtocol {
    func request<T: Codable>(url: String, completion: @escaping (Result<T, HttpError>) -> Void)
}

