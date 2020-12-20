//
//  MapViewController.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import UIKit
import RxSwift
import GoogleMaps
import RxCocoa
import RxGoogleMaps

class MapViewController: UIViewController {
        
    @IBOutlet weak var mapView: GMSMapView!
    
    private let disposeBag = DisposeBag()
    var viewModel: MapViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    func setupUI() {
        self.title = "Map".localized()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        mapView.isMyLocationEnabled = true
    }
    
    func addMarker(resourceViewModel: ResourceViewModel) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: resourceViewModel.lat, longitude: resourceViewModel.lon)
        marker.userData = resourceViewModel.element.id
        marker.title = resourceViewModel.name
        marker.snippet = resourceViewModel.latLongText
        //marker.icon = GMSMarker.markerImage(with: markerColor(companionId: resourceViewModel.companyZoneId))
        marker.map = mapView
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel, let mapView = mapView else { return }
        
        let location = mapView.rx.myLocation.asDriverOnErrorJustComplete()
        
        location.drive() { location in
            mapView.camera = GMSCameraPosition.camera(withLatitude: location?.coordinate.latitude ?? 0.0, longitude: location?.coordinate.longitude ?? 0.0, zoom: 15.0)
        }
        
        let input = MapViewModel.Input(trigger: Driver.merge(location.asDriver()))
        let output = viewModel.transform(input: input)

        output.items.drive() { [self] resources in
            _ = resources.map({addMarker(resourceViewModel: $0)
            })
        }.disposed(by: disposeBag)
        
        output.fetching
            .drive()
            .disposed(by: disposeBag)
    }
    
    func markerColor(companionId: Int) -> UIColor {
        return .black
    }
}
