import Foundation

enum CardType: String, Codable {
    case realEstate
    case favoriteSeller
    case clothing
    case all
    
    var getTitle: String {
        switch self {
        case .realEstate:
            return "Emlak"
        case .favoriteSeller:
            return "Favori Satıcılar"
        case .clothing:
            return "Giyim"
        case .all:
            return "Tümü"
        }
    }
}
