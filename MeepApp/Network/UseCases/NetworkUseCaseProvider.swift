//
//  NetworkUseCaseProvider.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation

final class NetworkUseCaseProvider: UseCaseProvider {
    
    private let repositoryProvider: RepositoryProvider

    init() {
        repositoryProvider = RepositoryProvider()
    }
    
    func makeUseCase<Element>() -> UseCaseImp<Element> {
        return UseCaseImp(repository: repositoryProvider.makeRepository())
    }
}

