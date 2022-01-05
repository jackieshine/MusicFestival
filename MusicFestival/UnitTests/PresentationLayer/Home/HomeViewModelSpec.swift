//
//  HomeViewModelSpec.swift
//  MusicFestivalTests
//
//  Created by Jackie on 2/1/22.
//

import XCTest
@testable import MusicFestival

class HomeViewModelSpec: XCTestCase {
  var viewModel: HomeViewModel!
  var viewControllerMock: HomeViewControllerMock!
  var festivalServiceMock: FestivalServiceMock!

  override func setUp() {
    super.setUp()
    viewControllerMock = HomeViewControllerMock()
    festivalServiceMock = FestivalServiceMock()
    viewModel = HomeViewModel(display: viewControllerMock, festivalService: festivalServiceMock)
  }

  override func tearDown() {
    viewModel = nil
    viewControllerMock = nil
    festivalServiceMock = nil
    super.tearDown()
  }

  func test_init_success() {
    XCTAssertNotNil(viewModel)
  }

  func test_viewDidAppear_get_data_success() {
    festivalServiceMock.getRecordLabelsResult = .success([])
    XCTAssertEqual(viewControllerMock.reloadTableViewCalled, false)
    viewModel.viewDidAppear()
    XCTAssertEqual(viewControllerMock.reloadTableViewCalled, true)
  }

  func test_viewDidAppear_get_data_failure() {
    festivalServiceMock.getRecordLabelsResult = .failure(.networkTimeout)
    XCTAssertEqual(viewControllerMock.showGenericErrorCalled, false)
    viewModel.viewDidAppear()
    XCTAssertEqual(viewControllerMock.showGenericErrorCalled, true)
  }
}

final class HomeViewControllerMock: HomeDisplay {
  var reloadTableViewCalled = false
  var showGenericErrorCalled = false

  func reloadTableView() {
    reloadTableViewCalled = true
  }

  func showGenericError(with handler: @escaping AlertAction) {
    showGenericErrorCalled = true
  }
}

final class FestivalServiceMock: FestivalUseCase {
  var getRecordLabelsResult: Result<[RecordLabel], NetworkError>?

  func getRecordLabels(completion: @escaping (Result<[RecordLabel], NetworkError>) -> Void) {
    if let result = getRecordLabelsResult {
      completion(result)
    }
  }
}
