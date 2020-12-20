//
//  MapViewModel.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import GoogleMaps

final class MapViewModel: RxViewModelType {
    
    struct Input {
        let trigger: Driver<CLLocation?>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let items: Driver<[ResourceViewModel]>
        let error: Driver<Error>
    }

    private let useCase: UseCaseImp<[Resource]>
    private let navigator: MapNavigator
    var city: String = "valencia"
    var lowerLeftLatLon: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    var upperRightLatLon: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    init(useCase: UseCaseImp<[Resource]>, navigator: MapNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let items = input.trigger.flatMapLatest { [self] (location) -> SharedSequence<DriverSharingStrategy, [ResourceViewModel]>  in
            lowerLeftLatLon = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude ?? 0.0) - 0.01 , longitude: (location?.coordinate.longitude ?? 0.0) - 0.02)
           upperRightLatLon = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude ?? 0.0) + 0.01, longitude: (location?.coordinate.longitude ?? 0.0) + 0.02)
            return self.useCase.execute(type: .resources(city: self.city, params: ["lowerLeftLatLon": self.lowerLeftLatLon.toJSON(), "upperRightLatLon":self.upperRightLatLon.toJSON()]))
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { ResourceViewModel(with: $0) }}
        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output(fetching: fetching,
                      items: items,
                      error: errors)
    }
}
