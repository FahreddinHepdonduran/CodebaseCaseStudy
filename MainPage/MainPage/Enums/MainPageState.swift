import Foundation

enum MainPageState {
    case idle
    case loading
    case list
    case error(_ errorModel: MaingPageErrorModel)
}

extension MainPageState: Equatable {
    
    static func == (lhs: MainPageState, rhs: MainPageState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading), (.list, .list):
            return true
        case let (.error(lhsError), .error(rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
    
}
