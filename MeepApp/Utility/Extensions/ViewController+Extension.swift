//
//  ViewController+Extension.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import UIKit

extension UIViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error".localized(), message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}
