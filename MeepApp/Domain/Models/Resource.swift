//
//  Resource.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation

public struct Resource: Codable {

    public var id: String
    public var name: String
    public var scheduledArrival: Int?
    public var locationType: Int?
    public var companyZoneId: Int
    public var lat: Double?
    public var lon: Double?
    
    public init(id: String, name: String, scheduledArrival: Int?, locationType: Int?, companyZoneId: Int, lat: Double?, lon: Double?) {
        self.id = id
        self.name = name
        self.scheduledArrival = scheduledArrival
        self.locationType = locationType
        self.companyZoneId = companyZoneId
        self.lat = lat
        self.lon = lon
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case scheduledArrival
        case locationType
        case companyZoneId
        case lat
        case lon
    }
}
