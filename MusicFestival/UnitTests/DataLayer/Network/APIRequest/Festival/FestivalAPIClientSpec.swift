//
//  FestivalAPIClientSpec.swift
//  MusicFestivalTests
//
//  Created by Jackie on 30/12/21.
//

import XCTest
@testable import MusicFestival

class FestivalAPIClientSpec: XCTestCase {
  var apiClient: FestivalAPIClient!
  var httpClient: HTTPClientMock!

  override func setUp() {
    super.setUp()
    httpClient = HTTPClientMock()
    apiClient = FestivalAPIClient(httpClient: httpClient)
  }

  override func tearDown() {
    httpClient = nil
    apiClient = nil
    super.tearDown()
  }

  func test_getFestivals_success() {
    httpClient.sendRequestShouldSucceed = true
    httpClient.mockJSONName = "FestivalResponse_Success"
    apiClient.getFestivals { festivals in
      XCTAssertEqual(festivals.count, 5)
    } failure: { error in
      XCTFail("Expecting success response.")
    }
  }

  func test_getFestivals_failure() {
    httpClient.sendRequestShouldSucceed = false
    apiClient.getFestivals { festivals in
      XCTFail("Expecting failure response.")
    } failure: { error in
      XCTAssertNotNil(error)
    }
  }

}

final class HTTPClientMock: HTTPRequestMaking {
  var completionCallback: (() -> Void)?
  var mockJSONName: String?
  var sendRequestShouldSucceed = false
  var requestPassed: APIRequest?
  var didInvokeSend = false
  var error: NetworkError?

  func send<T: Decodable>(_ request: APIRequest,
                          success: @escaping HTTPRequestSuccessAction<T>,
                          failure: @escaping HTTPRequestFailureAction) {
    send(request,
         callbackQueue: .main,
         success: success,
         failure: failure)
  }

  func send<T: Decodable>(_ request: APIRequest,
                          callbackQueue: DispatchQueue,
                          success: @escaping HTTPRequestSuccessAction<T>,
                          failure: @escaping HTTPRequestFailureAction) {
    didInvokeSend = true
    requestPassed = request
    if sendRequestShouldSucceed {
      if T.self == Data.self {
        success(Data() as! T)
      } else {
        if let mockJSONName = mockJSONName {
          guard let jsonData = Bundle(for: type(of: self)).jsonData(fromResource: mockJSONName) else {
            fatalError("We could not load the JSON test data with name: \(mockJSONName)")
          }

          let jsonDecoder = JSONDecoder()
          guard let mockResponse = try? jsonDecoder.decode(T.self, from: jsonData) else {
            fatalError("We could not decode the JSON object \(T.self)")
          }
          success(mockResponse)
        } else {
          failure(NetworkError.undefined(error: nil))
        }
      }
    } else {
      failure(error ?? .undefined(error: nil))
    }

    completionCallback?()
  }

  func cancelRequests() {}
}
