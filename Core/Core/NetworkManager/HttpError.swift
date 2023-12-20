import Foundation

public enum HttpError: Error {
    case badResponse, errorDecodingData, invalidURL
}
