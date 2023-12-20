//
//  MainPageVC.swift
//  MainPage
//
//  Created by Fahreddin Hepdonduran on 16.12.2023.
//

import UIKit
import UIComponents
import AppResources

public final class MainPageVC: UIViewController, AlertShowable {
    
    @IBOutlet private weak var headerView: HeaderView!
    @IBOutlet private weak var tableView: UITableView!
    
    private var refreshControl = UIRefreshControl()
    
    private var vm: MainPageViewModelProtocol = MainPageViewModel()
    
    public convenience init() {
        self.init(nibName: "MainPageVC", bundle: .AppBundle.MainPage.initBundle)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerCells()
        setupHeaderView()
        setupRefreshControl()
        vm.delegate = self
        vm.getMainPage()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configUI()
    }

}

// MARK: - MainPageViewModelDelegate
extension MainPageVC: MainPageViewModelDelegate {
    
    func didChangeState(_ state: MainPageState) {
        DispatchQueue.main.async {
            self.handleStateChange(state)
        }
    }
    
}

// MARK: - RealEstateCellDelegate
extension MainPageVC: RealEstateCellDelegate {
    
    func didSelectFavRealEstate(_ flag: Bool, _ model: CardDomainModel, _ index: Int) {
        saveDeleteFavItem(flag, model, index, .realEstate)
    }
    
}

// MARK: - FavoriteSellerCellDelegate
extension MainPageVC: FavoriteSellerCellDelegate {
    
    func didSelectFav(_ flag: Bool, _ model: CardDomainModel, _ index: Int) {
        saveDeleteFavItem(flag, model, index, .favoriteSeller)
    }
    
}

// MARK: - FilterHeaderViewDelegate
extension MainPageVC: FilterHeaderViewDelegate {
    
    func filterFor(type: CardType) {
        vm.currentFilterType = type
        vm.filter(forType: type)
    }
    
}

// MARK: - UICollectionViewDataSource
extension MainPageVC: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.filterCardModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = vm.filterCardModels[indexPath.row]
        
        switch model.type {
        case .realEstate:
            let cell = tableView.dequeueReusableCell(withIdentifier: RealEstateCell.description(), for: indexPath) as! RealEstateCell
            cell.delegate = self
            cell.configure(model, vm.isFavItemExist(with: model.id, forType: .realEstate), indexPath.row)
            return cell
        case .favoriteSeller:
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteSellerCell.description(), for: indexPath) as! FavoriteSellerCell
            cell.delegate = self
            cell.configure(model, vm.isFavItemExist(with: model.id, forType: .favoriteSeller), indexPath.row)
            return cell
        case .clothing:
            let cell = tableView.dequeueReusableCell(withIdentifier: ClothingCell.description(), for: indexPath) as! ClothingCell
            cell.configure(model)
            return cell
        case .all:
            return UITableViewCell()
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = FilterHeaderView(frame: .zero)
        view.delegate = self
        view.configure("For You", vm.mainPageModel?.getAllCardTypes ?? [], vm.currentFilterType)
        return view
    }
    
}

// MARK: - UITableViewDelegate
extension MainPageVC: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = vm.filterCardModels[indexPath.row]
        
        switch model.type {
        case .realEstate:
            return 256.0
        case .favoriteSeller:
            return 80.0
        case .clothing:
            return 184.0
        case .all:
            return 0.0
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 79.0
    }
    
}

// MARK: - Private Extensions
private extension MainPageVC {
    
    func configUI() { }
    
    func registerCells() {
        tableView.register(
            .init(nibName: RealEstateCell.description(), bundle: .AppBundle.MainPage.initBundle),
            forCellReuseIdentifier: RealEstateCell.description()
        )
        
        tableView.register(
            .init(nibName: ClothingCell.description(), bundle: .AppBundle.MainPage.initBundle),
            forCellReuseIdentifier: ClothingCell.description()
        )
        
        tableView.register(
            .init(nibName: FavoriteSellerCell.description(), bundle: .AppBundle.MainPage.initBundle),
            forCellReuseIdentifier: FavoriteSellerCell.description()
        )
    }
    
    func setupTableView() {
        tableView.contentInset = .init(top: 30.0, left: 0.0, bottom: -20.0, right: 0.0)
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func setupHeaderView() {
        let filterButton = FilterButton(frame: .zero)
        filterButton.addTarget(self, action: #selector(filterBtnAction(_:)), for: .touchUpInside)
        
        headerView.addRightItem(filterButton)
    }
    
    func setHeaderData() {
        guard let model = vm.mainPageModel else { return }
        
        headerView.setImage(model.owner.profileImage)
        headerView.setTitle(model.owner.fullName)
    }
    
    @objc
    func filterBtnAction(_ sender: UIButton) {
        print("filter button tapped")
    }
    
    func handleStateChange(_ state: MainPageState) {
        switch state {
        case .idle:
            break
        case .loading:
            print("loading")
        case .list:
            setHeaderData()
            tableView.reloadData()
            tableView.refreshControl?.endRefreshing()
        case .error(let errorModel):
            showAlert(self, errorModel.title, errorModel.desription)
        }
    }
    
    @objc
    func refreshData() {
        vm.currentFilterType = .all
        vm.getMainPage()
    }
    
    func saveDeleteFavItem(_ flag: Bool, _ model: CardDomainModel, _ index: Int, _ forType: CardType) {
        if flag {
            vm.saveFavItem(with: model.id, forType: forType)
            return
        }
        
        vm.deleteFavItem(with: model.id, forType: forType)
    }
    
}
