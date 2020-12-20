//
//  RxViewModelType.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import Foundation

protocol RxViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
