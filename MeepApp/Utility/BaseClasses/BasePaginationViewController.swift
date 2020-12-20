//
//  BasePaginationViewController.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import UIKit

protocol BasePaginationViewPresenter {
    func setup(_ viewModels: [Any])
    func hidePTR()
    func refresh()
    func showError(errorMessage: String)
}
