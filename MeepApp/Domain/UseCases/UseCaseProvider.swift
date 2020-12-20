//
//  UseCaseProvider.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation

protocol UseCaseProvider {
    func makeUseCase<Element: Codable>() -> UseCaseImp<Element>
}
