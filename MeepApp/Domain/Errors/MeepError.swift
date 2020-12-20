//
//  MeepError.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation

public struct MeepError: Codable, Error {

    public let errorCode: String?

    public init(errorCode: String?) {
        self.errorCode = errorCode
    }
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
    }
    
    func toString() -> String {
        guard let errorCode = errorCode else { return "" }
        switch CommonError(rawValue: errorCode) {
        case .COMMON_ERROR:
            return "ERROR".localized()
        default:
            return ""
        }
    }
}
