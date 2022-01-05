//
//  URLRequest+ExtensionSpec.swift
//  MusicFestivalTests
//
//  Created by Jackie on 30/12/21.
//

import XCTest
@testable import MusicFestival

class URLRequest_ExtensionSpec: XCTestCase {
  var request: URLRequest!

  override func setUp() {
    super.setUp()
    request = URLRequest(url: URL(string: "https://eacp.energyaustralia.com.au")!)
  }

  override func tearDown() {
    request = nil
    super.tearDown()
  }

  func test_setHeader_success() {
    request.setHeader(["header1":"test"])
    let headerValue = request.value(forHTTPHeaderField: "header1")
    XCTAssertEqual(headerValue, "test")
  }

  func test_addHeader_success() {
    request.addHeader(["header2":"test2"])
    let headerValue = request.value(forHTTPHeaderField: "header2")
    XCTAssertEqual(headerValue, "test2")
  }
}
