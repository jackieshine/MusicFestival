//
//  APIErrorCreatorSpec.swift
//  MusicFestivalTests
//
//  Created by Jackie on 30/12/21.
//

import XCTest
@testable import MusicFestival

class APIErrorCreatorSpec: XCTestCase {
  var apiErrorCreator: APIErrorCreator!

  override func setUp() {
    super.setUp()
    apiErrorCreator = APIErrorCreator()
  }

  override func tearDown() {
    apiErrorCreator = nil
    super.tearDown()
  }

  func test_decodeAPIError_with_nil() {
    let error = apiErrorCreator.decodeAPIError(fromData: nil)
    XCTAssertNil(error)
  }

  func test_decodeAPIError_with_input() {
    let error = apiErrorCreator.decodeAPIError(fromData: "Test".data(using: .utf8))
    XCTAssertNotNil(error)
  }
}
