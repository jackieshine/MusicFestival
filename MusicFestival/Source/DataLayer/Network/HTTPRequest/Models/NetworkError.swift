//
//  NetworkError.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import Foundation

/// Errors from making network requests. It should be handled in Data Layer.
enum NetworkError: Error {
  /// The `HTTPClient` is unable to create a `URLRequest` from a given `APIRequest`
  case malformedRequest(request: APIRequest?)

  /// Request succeeded but no data was returned.
  case successWithNoData

  /// Undefined request error.
  case undefined(error: Error?)

  /// No internet connection available.
  case notConnectedToInternet

  /// Network timeout occurred.
  case networkTimeout

  /// The request was cancelled.
  case requestCancelled

  /// Receive an HTTP response with a status code that was not within the 200 range.
  case badRequest(withStatusCode: HTTPStatusCode, responseError: APIError?)

  /// The HTTP request was successful but the response could not be decoded.
  case uninterpretableResponse

  // MARK: - Initialisation

  init(_ error: Error) {
    let error = error as NSError

    switch error.code {
    case NSURLErrorTimedOut where error.domain == NSURLErrorDomain:
      self = .networkTimeout
    case NSURLErrorDataNotAllowed where error.domain == NSURLErrorDomain,
         NSURLErrorNotConnectedToInternet where error.domain == NSURLErrorDomain:
      self = .notConnectedToInternet
    case NSURLErrorCancelled where error.domain == NSURLErrorDomain:
      self = .requestCancelled
    default:
      self = .undefined(error: error)
    }
  }
}
