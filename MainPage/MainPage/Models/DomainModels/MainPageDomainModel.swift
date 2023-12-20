import Foundation

struct MainPageDomainModel {
    let owner: OwnerDomainModel
    let cards: [CardDomainModel]
    
    var getAllCardTypes: [CardType] {
        var typeArray: [CardType] = [.all]
        
        cards.forEach { model in
            if !typeArray.contains(model.type) {
                typeArray.append(model.type)
            }
        }
        
        return typeArray
    }
}
