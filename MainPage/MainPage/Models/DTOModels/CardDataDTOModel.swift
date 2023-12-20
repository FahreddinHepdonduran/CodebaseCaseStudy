import Foundation

struct CardDataDTOModel: Codable {
    let id: Int
    let title: String?
    let address: CardDataAddresssDTOModel?
    let price: Int?
    let currency: String?
    let badges: [String]?
    let images: [String]?
    let name: String?
    let surname: String?
    let registerDate: String?
    let profileImage: String?
}
