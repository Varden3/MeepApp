//
//  CLLocationCoordinate2D+Extension.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation
import GoogleMaps

extension CLLocationCoordinate2D {
    func toJSON() -> String {
        return "\(self.latitude),\(self.longitude)"
    }
}
