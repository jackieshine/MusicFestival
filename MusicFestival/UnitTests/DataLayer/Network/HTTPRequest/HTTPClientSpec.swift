//
//  HTTPClientSpec.swift
//  MusicFestivalTests
//
//  Created by Jackie on 30/12/21.
//

import XCTest
@testable import MusicFestival

class HTTPClientSpec: XCTestCase {

  func test_init_successfully() {
    let httpClientWithNormalTimeout = HTTPClient(useExtendedTimeout: false)
    XCTAssertNotNil(httpClientWithNormalTimeout)
    let httpClientWithExtendedTimeout = HTTPClient(useExtendedTimeout: true)
    XCTAssertNotNil(httpClientWithExtendedTimeout)
  }
}
