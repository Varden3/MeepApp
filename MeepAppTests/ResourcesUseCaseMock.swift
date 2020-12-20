//
//  ResourcesUseCaseMock.swift
//  MeepAppTests
//
//  Created by Sergio Castillo on 20/12/2020.
//

@testable import MeepApp
import RxSwift

final class ResourcesUseCaseMock<Resource: Codable>: UseCase {
    var resources_ReturnValue: Observable<[Resource]> = Observable.just([])
    var resources_Called = false

    func execute(type: UseCaseType) -> Observable<[Resource]> {
        resources_Called = true
        return resources_ReturnValue
    }
}
