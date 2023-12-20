import Foundation

public final class NetworkManager: NetworkManagerProtocol {
    
    private var session: URLSession!
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<T: Codable>(url: String, completion: @escaping (Result<T, HttpError>) -> Void) {
        guard let URL = URL(string: url) else {
            completion(.failure(HttpError.invalidURL))
            return
        }
        
        session.dataTask(with: URL, completionHandler: { data, response, error in
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(HttpError.badResponse))
                return
            }
            
            guard let data = data, let object = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(HttpError.errorDecodingData))
                return
            }
            
            completion(.success(object))
        })
        .resume()
    }
    
}
