//
//  ResourceViewModel.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation
import UIKit
import GoogleMaps

final class ResourceViewModel: BaseViewModel<Resource> {
           
    required init(with resource: Resource) {
        super.init(with: resource)
    }
    
    var name: String {
        return element.name
    }
    
    var companyZoneId: Int {
        return element.companyZoneId
    }
    
    var locationType: Int {
        return element.locationType ?? 0
    }
    
    var lat: CLLocationDegrees {
        return element.lat ?? 0.0
    }
    
    var lon: CLLocationDegrees {
        return element.lon ?? 0.0
    }
    
    var latLongText: String {
        return "lat: \(element.lat ?? 0.0)\nlon: \(element.lon ?? 0.0)"
    }
}
