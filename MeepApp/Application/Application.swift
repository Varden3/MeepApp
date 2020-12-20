//
//  Application.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation
import UIKit

final class Application {
    static let shared = Application()

    private let useCaseProvider: UseCaseProvider
    private var navigatorProvider: NavigatorProvider?

    private init() {
        self.useCaseProvider = NetworkUseCaseProvider()
    }

    func configureMainInterface(in window: UIWindow) {
        navigatorProvider = NavigatorProvider(services: useCaseProvider)
        let navigationController = navigatorProvider?.makeMap()
        window.rootViewController = navigationController
    }
}

