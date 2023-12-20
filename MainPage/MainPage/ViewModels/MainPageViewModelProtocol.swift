import Foundation

protocol MainPageViewModelProtocol {
    var mainPageModel: MainPageDomainModel? { get set }
    var filterCardModels: [CardDomainModel] { get set }
    var state: MainPageState { get set }
    var currentFilterType: CardType { get set }
    var delegate: MainPageViewModelDelegate? { get set }
    
    func getMainPage()
    func filter(forType: CardType)
    func saveFavItem(with id: Int, forType: CardType)
    func deleteFavItem(with id: Int, forType: CardType)
    func isFavItemExist(with id: Int, forType: CardType) -> Bool
}
