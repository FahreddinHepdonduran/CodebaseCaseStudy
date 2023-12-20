import Foundation

struct CardDTOModel: Codable {
    let type: CardType
    let data: CardDataDTOModel
}

extension CardDTOModel {
    
    func convertToCardDomainModel() -> CardDomainModel {
        .init(
            type: type, id: data.id, title: data.title, city: data.address?.city, district: data.address?.district,
            price: data.price, currency: data.currency, badges: data.badges, images: data.images, name: data.name, surname: data.surname,
            registerDate: data.registerDate, profileImage: data.profileImage
        )
    }
    
}
