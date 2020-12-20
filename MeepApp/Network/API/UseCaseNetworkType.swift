//
//  UseCaseNetworkType.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Alamofire

public struct UseCaseNetworkType {
    
    let type: UseCaseType
    
    init(type: UseCaseType) {
        self.type = type
    }
    
    public var endpoint: String {
        switch type {
        case .resources(let city, _):
            return "routers/\(city)/resources"
        }
    }
    
    public var method: HTTPMethod {
        switch type {
        case .resources:
            return .get
        default:
            return .post
        }
    }
    
    public var params: [String: Any]? {
        switch type {
        case .resources(_, let params):
            return params
        default:
            return nil
        }
    }
}
