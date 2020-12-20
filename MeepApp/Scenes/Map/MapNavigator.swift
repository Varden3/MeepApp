//
//  MapNavigator.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import UIKit

protocol MapNavigator: BaseNavigator {
    func toMap()
}

class DefaultMapNavigator: MapNavigator {
    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: UseCaseProvider
    private let navigatorProvider: NavigatorProvider

    init(services: UseCaseProvider, navigatorProvider: NavigatorProvider,
         navigationController: UINavigationController,
         storyboard: UIStoryboard) {
        self.services = services
        self.navigatorProvider = navigatorProvider
        self.navigationController = navigationController
        self.storyboard = storyboard
    }
    
    func toItem(_ item: Any) {
        if item is Resource {
            let resource = item as! Resource
            toResourceDetail(resource: resource)
        }
    }
    
    func toMap() {
        navigatorProvider.navigationController = navigationController
        let vc = navigatorProvider.makeMap()
        navigationController.pushViewController(vc, animated: true)
    }

    func toResourceDetail(resource: Resource) {
        navigatorProvider.navigationController = navigationController
        let vc = navigatorProvider.makeResourceDetail(resource: resource)
        navigationController.pushViewController(vc, animated: true)
    }
}
