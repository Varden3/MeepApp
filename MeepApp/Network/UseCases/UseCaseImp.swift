//
//  UseCaseImp.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation
import RxSwift

final class UseCaseImp<Element: Codable>: UseCase {
    
    private let repository: RepositoryImp<Element>

    init(repository: RepositoryImp<Element>) {
        self.repository = repository
    }
    
    func execute(type: UseCaseType) -> Observable<Element> {
        return repository.execute(type: type)
    }
}
