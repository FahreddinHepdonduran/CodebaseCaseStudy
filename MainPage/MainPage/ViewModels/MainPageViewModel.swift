import Foundation
import Core

final class MainPageViewModel: MainPageViewModelProtocol {
    
    var mainPageModel: MainPageDomainModel?
    var filterCardModels: [CardDomainModel] = []
    var currentFilterType: CardType = .all
    
    var state: MainPageState = .idle {
        didSet {
            delegate?.didChangeState(state)
        }
    }
    
    var delegate: MainPageViewModelDelegate?
    
    private var fetchMainPageBusinessLogic: FetchMainPageBusinessLogicProtocol!
    private var coreDataManager = CoreDataManager.shared
    
    init(fetchMainPageBusinessLogic: FetchMainPageBusinessLogicProtocol = FetchMainPageBusinessLogic()) {
        self.fetchMainPageBusinessLogic = fetchMainPageBusinessLogic
    }
    
    func getMainPage() {
        state = .loading
        
        fetchMainPageBusinessLogic.fetch { [weak self] (result: Result<MainPageDomainModel, MaingPageErrorModel>) in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.mainPageModel = data
                self.filterCardModels = data.cards
                self.state = .list
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
    
    func filter(forType: CardType) {
        guard let mainPageModel else { return }
        
        if forType == .all {
            filterCardModels = mainPageModel.cards
            state = .list
            return
        }
        
        filterCardModels = mainPageModel.cards.filter({ $0.type == forType })
        state = .list
    }
    
    func saveFavItem(with id: Int, forType: CardType) {
        let flag = forType == .favoriteSeller
        coreDataManager.saveItem(id, forType: flag ? .favoriteSeller : .realEstate)
    }
    
    func deleteFavItem(with id: Int, forType: CardType) {
        let flag = forType == .favoriteSeller
        coreDataManager.deleteItemByID(id: id, forType: flag ? .favoriteSeller : .realEstate)
    }
    
    func isFavItemExist(with id: Int, forType: CardType) -> Bool {
        let flag = forType == .favoriteSeller
        return coreDataManager.containsItem(with: id, forType: flag ? .favoriteSeller : .realEstate)
    }
    
}
