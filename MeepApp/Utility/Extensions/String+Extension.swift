//
//  String+Extension.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
