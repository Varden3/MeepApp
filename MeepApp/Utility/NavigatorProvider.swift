//
//  NavigatorProvider.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import UIKit

final class NavigatorProvider {
    
    private let services: UseCaseProvider
    public var navigationController: UINavigationController

    init(services: UseCaseProvider) {
        self.services = services
        self.navigationController = UINavigationController()
    }
    
    func makeMap() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigator = DefaultMapNavigator(services: services, navigatorProvider: self,
        navigationController: navigationController,
        storyboard: storyboard)
        let vc = storyboard.instantiateViewController(ofType: MapViewController.self)
        vc.viewModel = MapViewModel(useCase: services.makeUseCase(),
                                           navigator: navigator)
        return vc
    }
    
    func makeResourceDetail(resource: Resource) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(ofType: ResourceDetailViewController.self)
        vc.viewModel = ResourceViewModel(with: resource)
        return vc
    }
}
