import Foundation

struct OwnerDomainModel {
    let name: String
    let surname: String
    let profileImage: String
    
    var fullName: String {
        name + " " + surname
    }
}
