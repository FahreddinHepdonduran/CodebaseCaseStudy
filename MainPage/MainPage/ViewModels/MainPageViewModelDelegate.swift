import Foundation

protocol MainPageViewModelDelegate: AnyObject {
    func didChangeState(_ state: MainPageState)
}
