//
//  Repository.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation
import RxSwift

protocol Repository {
    associatedtype Item: Codable
    func execute(type: UseCaseType) -> Observable<Item>
}

final class RepositoryImp<Element: Codable>: Repository {
    
    private let network: NetworkImp<Element>
        
    init(network: NetworkImp<Element>) {
        self.network = network
    }
    
    func execute(type: UseCaseType) -> Observable<Element> {
        return network.execute(type: UseCaseNetworkType(type: type))
    }
}
