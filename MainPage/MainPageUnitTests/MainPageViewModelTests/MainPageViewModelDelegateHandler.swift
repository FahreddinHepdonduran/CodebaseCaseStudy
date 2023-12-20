import Foundation
@testable import MainPage

final class MainPageViewModelDelegateHandler: MainPageViewModelDelegate {
    
    var currentState: MainPageState = .idle
    var stateUpdateCount = 0
    
    func didChangeState(_ state: MainPageState) {
        currentState = state
        stateUpdateCount += 1
    }
    
}
