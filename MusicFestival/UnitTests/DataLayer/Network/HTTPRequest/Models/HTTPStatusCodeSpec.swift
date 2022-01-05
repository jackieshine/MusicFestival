//
//  HTTPStatusCodeSpec.swift
//  MusicFestivalTests
//
//  Created by Jackie on 30/12/21.
//

import XCTest
@testable import MusicFestival

class HTTPStatusCodeSpec: XCTestCase {
  func test_init_success_with_code_200() {
    let statusCode = HTTPStatusCode(rawValue: 200)
    XCTAssertEqual(statusCode, .success)
  }

  func test_init_success_with_code_400() {
    let statusCode = HTTPStatusCode(rawValue: 400)
    XCTAssertEqual(statusCode, .badRequest)
  }

  func test_init_success_with_code_999() {
    let statusCode = HTTPStatusCode(rawValue: 999)
    XCTAssertEqual(statusCode, .undefined)
  }
}
