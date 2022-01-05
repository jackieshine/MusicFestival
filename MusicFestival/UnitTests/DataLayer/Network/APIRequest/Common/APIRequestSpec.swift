//
//  APIRequestSpec.swift
//  MusicFestivalTests
//
//  Created by Jackie on 31/12/21.
//

import XCTest
@testable import MusicFestival

struct TestAPIRequest: APIRequest {
  var appConfigurationClient: AppConfigurationProviding = AppConfigurationMock()

  var path: String = ""
}

class APIRequestSpec: XCTestCase {
  var request: TestAPIRequest!

  override func setUp() {
    super.setUp()
    request = TestAPIRequest()
  }

  override func tearDown() {
    request = nil
    super.tearDown()
  }

  func test_default_http_method() {
    XCTAssertEqual(request.method, .get)
  }

  func test_default_headers() {
    XCTAssertEqual(request.headers, [:])
  }

  func test_default_parameters() {
    XCTAssertNil(request.parameters)
  }

  func test_default_body() {
    XCTAssertNil(request.body)
  }

  func test_asURLRequest_failure_path_invalid() {
    struct InvalidRequest: APIRequest {
      var path: String = "dff39*$*(@^()%^"
      var appConfigurationClient: AppConfigurationProviding = AppConfigurationClient()
    }
    let request = InvalidRequest()
    let urlrequest = request.asURLRequest()
    XCTAssertNil(urlrequest)
  }

  func test_asURLRequest_success_with_parameter() {
    struct RequestWithParameter: APIRequest {
      var path: String = "api"
      var appConfigurationClient: AppConfigurationProviding = AppConfigurationClient()
      var parameters: [String : Encodable]? {
        [
          "query": "query"
        ]
      }
    }

    let request = RequestWithParameter()
    let urlrequest = request.asURLRequest()
    XCTAssertEqual(urlrequest?.url?.absoluteString, "https://eacp.energyaustralia.com.au/codingtest/api?query=query")
  }

  func test_asURLRequest_success_with_different_http_method() {
    struct RequestWithHTTPMethod: APIRequest {
      var path: String = "api"
      var appConfigurationClient: AppConfigurationProviding = AppConfigurationClient()
      var method: HTTPRequestMethod { .post }
    }

    let request = RequestWithHTTPMethod()
    let urlrequest = request.asURLRequest()
    XCTAssertEqual(urlrequest?.httpMethod, "POST")
  }

  func test_bodyToJSON_success() {
    let body = ["query":"item"]
    let jsonData = request.bodyToJSON(body)
    if let jsonData = jsonData {
      XCTAssertEqual(String(data: jsonData, encoding: .utf8), "{\n  \"query\" : \"item\"\n}")
    } else {
      XCTFail("Expected to have a jsonData")
    }
  }
}


final class AppConfigurationMock: AppConfigurationProviding {
  var apiTimeout: TimeInterval { 30 }

  var apiExtendedTimeout: TimeInterval { 60 }

  var apiEndPoint: URL? {
    URL(string: mockURL ?? "")
  }

  var mockURL: String?

  func setEndPoint(_ urlString: String) {
    mockURL = urlString
  }
}
