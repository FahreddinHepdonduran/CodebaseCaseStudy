import Foundation

struct OwnerDTOModel: Codable {
    let name: String
    let surname: String
    let registerDate: String
    let profileImage: String
}

extension OwnerDTOModel {
    
    func convertToOwnerDomainModel() -> OwnerDomainModel {
        .init(name: name, surname: surname, profileImage: profileImage)
    }
    
}
