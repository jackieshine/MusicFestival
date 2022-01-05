//
//  FestivalAPIRequestSpec.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import XCTest
@testable import MusicFestival

class FestivalAPIRequestSpec: XCTestCase {
  var festivalAPIRequest: FestivalAPIRequest!

  override func setUp() {
    super.setUp()
    festivalAPIRequest = FestivalAPIRequest()
  }

  override func tearDown() {
    festivalAPIRequest = nil
    super.tearDown()
  }

  func test_path() {
    XCTAssertEqual(festivalAPIRequest.path, "api/v1/festivals")
  }
}
