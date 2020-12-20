//
//  MapNavigatorMock.swift
//  MeepAppTests
//
//  Created by Sergio Castillo on 20/12/2020.
//

@testable import MeepApp
import RxSwift

class MapNavigatorMock: MapNavigator {

    var toMap_Called = false

    func toMap() {
        toMap_Called = true
    }
    
    func toItem(_ item: Any) {
        
    }
}
