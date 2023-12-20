import Foundation

struct MainPageDTOModel: Codable {
    let owner: OwnerDTOModel
    let cards: [CardDTOModel]
}

extension MainPageDTOModel {
    
    func convertToMainPageDomainModel() -> MainPageDomainModel {
        .init(owner: owner.convertToOwnerDomainModel(), cards: cards.map({ $0.convertToCardDomainModel() }))
    }
    
}
