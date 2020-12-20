//
//  ResourceDetailViewController.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import UIKit
import RxSwift
import RxCocoa

class ResourceDetailViewController: UIViewController {
 
    @IBOutlet weak var nameLabel: UILabel!
    
    var viewModel: ResourceViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
    }
}




