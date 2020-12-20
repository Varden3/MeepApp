//
//  ReusableRxTableViewController.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import UIKit
import RxSwift
import RxCocoa

class ReusableRxTableViewController<ItemViewModel: BaseViewModel<Model>, Model: Codable, BasicTableViewCell: BasePaginationTableViewCell<ItemViewModel>, Navigator: BaseNavigator>: UITableViewController {
 
    private let disposeBag = DisposeBag()
    var viewModel: ReusableRxViewModel<Model, Navigator, BaseViewModel<Model>>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }
    
    private func configureTableView() {
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.tableFooterView = UIView()
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let pull = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let input = ReusableRxViewModel<Model, Navigator, BaseViewModel<Model>>.Input(trigger: Driver.merge(viewWillAppear, pull), selection: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input: input)

        output.items.drive(tableView.rx.items(cellIdentifier: BasicTableViewCell.reuseID, cellType: BasicTableViewCell.self)) { tv, viewModel, cell in
            let tableCell = cell as BasicTableViewCell
            tableCell.bind(ItemViewModel(with: viewModel.element))
        }.disposed(by: disposeBag)
        
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        output.selectedItem
            .drive()
            .disposed(by: disposeBag)
    }
}




