//
//  RepositoryProvider.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation

final class RepositoryProvider {
    
  private let networkProvider: NetworkProvider
    
  public init() {
      networkProvider = NetworkProvider()
  }
    
  public func makeRepository<Element>() -> RepositoryImp<Element> {
      return RepositoryImp(network: networkProvider.makeNetwork())
  }
}
