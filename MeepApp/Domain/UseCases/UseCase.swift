//
//  UseCase.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation
import RxSwift

public protocol UseCase {
    associatedtype Item: Codable
    func execute(type: UseCaseType) -> Observable<Item>
}
