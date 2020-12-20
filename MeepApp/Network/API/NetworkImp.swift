//
//  NetworkImp.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Alamofire
import RxSwift

public final class NetworkImp<Element: Codable> {
    private let network: Network<Element>

    init(network: Network<Element>) {
        self.network = network
    }
    
    func execute(type: UseCaseNetworkType) -> Observable<Element> {
        return network.makeRequest(type: type)
    }
}

struct MapFromNever: Error {}
extension ObservableType where Element == Never {
    func map<T>(to: T.Type) -> Observable<T> {
        return self.flatMap { _ in
            return Observable<T>.error(MapFromNever())
        }
    }
}
