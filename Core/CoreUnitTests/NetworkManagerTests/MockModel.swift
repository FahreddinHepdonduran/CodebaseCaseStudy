import Foundation

struct MockModel: Codable {
    let cats: [MockModelCats]
}
        
struct MockModelCats: Codable {
    let id: String
    let url: String
}

struct NotMatchingKeysMockModel: Codable {
    let catts: [MockModelCats]
}
