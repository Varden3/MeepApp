//
//  MeepAppTests.swift
//  MeepAppTests
//
//  Created by Sergio Castillo on 19/12/2020.
//

@testable import MeepApp
import XCTest
import RxSwift
import RxCocoa
import RxBlocking
import GoogleMaps

enum TestError: Error {
  case test
}

class MapViewModelTests: XCTestCase {

    var resourcesUseCase: ResourcesUseCaseMock<Resource>!
    var mapNavigator: MapNavigatorMock!
    var viewModel: MapViewModel!
    var location: CLLocation!

    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()

        let useCaseProvider = NetworkUseCaseProvider()
        mapNavigator = MapNavigatorMock()
        location = CLLocation(latitude: 0.0, longitude: 0.0)
        
        viewModel = MapViewModel(useCase: useCaseProvider.makeUseCase(),
                               navigator: mapNavigator)
    }

    func test_transform_triggerInvoked_resourcesEmited() {
        // arrange
        let trigger = PublishSubject<CLLocation?>()
        let input = createInput(trigger: trigger)
        let output = viewModel.transform(input: input)

        // act
        output.items.drive().disposed(by: disposeBag)
        trigger.onNext((location))

        // assert
        XCTAssert(resourcesUseCase.resources_Called)
    }


    func test_transform_sendResource_trackFetching() {
        // arrange
        let trigger = PublishSubject<CLLocation?>()
        let output = viewModel.transform(input: createInput(trigger: trigger))
        let expectedFetching = [true, false]
        var actualFetching: [Bool] = []

        // act
        output.fetching
            .do(onNext: { actualFetching.append($0) },
                onSubscribe: { actualFetching.append(true) })
            .drive()
            .disposed(by: disposeBag)
        trigger.onNext((location))

        // assert
        XCTAssertEqual(actualFetching, expectedFetching)
    }

    func test_transform_resourcesEmitError_trackError() {
        // arrange
        let trigger = PublishSubject<CLLocation?>()
        let output = viewModel.transform(input: createInput(trigger: trigger))
        resourcesUseCase.resources_ReturnValue = Observable.error(TestError.test)

        // act
        output.items.drive().disposed(by: disposeBag)
        output.error.drive().disposed(by: disposeBag)
        trigger.onNext((location))
        let error = try! output.error.toBlocking().first()

        // assert
        XCTAssertNotNil(error)
    }

    func test_transform_triggerInvoked_mapResourcesToViewModels() {
        // arrange
        let trigger = PublishSubject<CLLocation?>()
        let output = viewModel.transform(input: createInput(trigger: trigger))
        resourcesUseCase.resources_ReturnValue = Observable.just(createResources())

        // act
        output.items.drive().disposed(by: disposeBag)
        trigger.onNext((location))
        let items = try! output.items.toBlocking().first()!

        // assert
        XCTAssertEqual(items.count, 2)
    }

    private func createInput(trigger: Observable<CLLocation?> = Observable.just(CLLocation(latitude: 0.0, longitude: 0.0)))
    -> MapViewModel.Input {
        return MapViewModel.Input(
        trigger: trigger.asDriverOnErrorJustComplete())
    }

    private func createResources() -> [Resource] {
        return [
            Resource(id: "asfd", name: "Resource 1", scheduledArrival: 2, locationType: 21, companyZoneId: 213, lat: 0.0, lon: 0.0),
            Resource(id: "fgh", name: "Resource 2", scheduledArrival: 6, locationType: 563, companyZoneId: 343, lat: 2.2, lon: 2.2)
        ]
    }
}
