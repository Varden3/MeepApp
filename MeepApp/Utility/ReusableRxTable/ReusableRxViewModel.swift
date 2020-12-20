//
//  ReusableRxViewModel.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation
import RxSwift
import RxCocoa

final class ReusableRxViewModel<Model: Codable, Navigator: BaseNavigator, ItemViewModel: BaseViewModel<Model>>: RxViewModelType {

    struct Input {
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let items: Driver<[ItemViewModel]>
        let selectedItem: Driver<Model>
        let error: Driver<Error>
    }

    private let useCase: UseCaseImp<[Model]>
    private let navigator: Navigator
    private let useCaseType: UseCaseType
    
    init(useCase: UseCaseImp<[Model]>, navigator: Navigator, useCaseType: UseCaseType) {
        self.useCase = useCase
        self.navigator = navigator
        self.useCaseType = useCaseType
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let items = input.trigger.flatMapLatest {
            return self.useCase.execute(type: self.useCaseType)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { ItemViewModel(with: $0) }}
        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        let selectedItem = input.selection
            .withLatestFrom(items) { (indexPath, items) -> Model in
                return items[indexPath.row].element
            }
            .do(onNext: navigator.toItem)
        
        return Output(fetching: fetching,
                      items: items,
                      selectedItem: selectedItem,
                      error: errors)
    }
}
