//
//  AppConfigurationClientSpec.swift
//  MusicFestivalTests
//
//  Created by Jackie on 30/12/21.
//

import XCTest
@testable import MusicFestival

class AppConfigurationClientSpec: XCTestCase {
  var appConfigurationClient: AppConfigurationClient!

  override func setUp() {
    super.setUp()
    appConfigurationClient = AppConfigurationClient()
  }

  override func tearDown() {
    appConfigurationClient = nil
    super.tearDown()
  }

  func test_api_timeout() {
    XCTAssertEqual(appConfigurationClient.apiTimeout, 30)
  }

  func test_api_extended_timeout() {
    XCTAssertEqual(appConfigurationClient.apiExtendedTimeout, 60)
  }

  func test_api_end_point() {
    XCTAssertEqual(appConfigurationClient.apiEndPoint, URL(string: "https://eacp.energyaustralia.com.au/codingtest/"))
  }
  
}
