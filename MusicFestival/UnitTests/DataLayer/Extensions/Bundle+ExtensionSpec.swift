//
//  Bundle+ExtensionSpec.swift
//  MusicFestivalTests
//
//  Created by Jackie on 30/12/21.
//

import XCTest
@testable import MusicFestival

class Bundle_ExtensionSpec: XCTestCase {
  func test_jsonData_fromResource_failure() {
    let data = Bundle.main.jsonData(fromResource: "test")
    XCTAssertNil(data)
  }
}
