//
//  NetworkErrorSpec.swift
//  MusicFestivalTests
//
//  Created by Jackie on 30/12/21.
//

import XCTest
@testable import MusicFestival

class NetworkErrorSpec: XCTestCase {
  func test_init_success_networkTimeout() {
    let error = NetworkError(NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil))
    XCTAssertNotNil(error)
  }

  func test_init_success_notConnectedToInternet() {
    let error = NetworkError(NSError(domain: NSURLErrorDomain, code: NSURLErrorDataNotAllowed, userInfo: nil))
    XCTAssertNotNil(error)
  }

  func test_init_success_requestCancelled() {
    let error = NetworkError(NSError(domain: NSURLErrorDomain, code: NSURLErrorCancelled, userInfo: nil))
    XCTAssertNotNil(error)
  }

  func test_init_success_default() {
    let error = NetworkError(NSError(domain: "", code: NSURLErrorCancelled, userInfo: nil))
    XCTAssertNotNil(error)
  }
}
