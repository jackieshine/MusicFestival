//
//  APIRequest.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import Foundation

/// Base protocol describing all HTTPS Requests APIs.
protocol APIRequest {
  /// The application's configuration.
  var appConfigurationClient: AppConfigurationProviding { get }

  /// Method to use for the request e.g. `.post`, `.get`, etc. By default, requests are `.get` requests unless overridden.
  var method: HTTPRequestMethod { get }

  /// Path to the API endpoint for the request, added to the base URL.
  var path: String { get }

  // Headers to add to the request. By default, headers are `[:]` unless overridden.
  var headers: [String: String] { get }

  /// The request parameters to send for a get request (optional).
  var parameters: [String: Encodable]? { get }

  /// The request body for a post request (optional).
  var body: Data? { get }

  /// Converts the APIRequest into an URLRequest that can be executed using a DataTask to perform a request.
  /// - Returns: The configured URLRequest.
  func asURLRequest() -> URLRequest?

  /// Encodes any type to Data type.
  /// - Parameters:
  ///   - body: The body of the api request.
  /// - Returns: Encoded value.
  func bodyToJSON<T: Encodable>(_ body: T) throws -> Data?
}

// MARK: - Default implementations for a APIRequest

extension APIRequest {
  var method: HTTPRequestMethod { .get }

  var headers: [String: String] { [:] }

  var parameters: [String: Encodable]? { nil }

  var body: Data? { nil }

  func asURLRequest() -> URLRequest? {
    let endpointURL = appConfigurationClient.apiEndPoint

    guard var url = URL(string: path, relativeTo: endpointURL) else {
      return nil
    }

    if let parameters = parameters {
      let urlWithQueryString = self.url(url, withQuery: parameters)!
      url = urlWithQueryString
    }

    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.setHeader(headers)

    if self.method != .get {
      request.httpBody = body
    }

    return request
  }

  func bodyToJSON<T: Encodable>(_ body: T) -> Data? {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    encoder.dateEncodingStrategy = .iso8601
    let jsonData = try? encoder.encode(body)
    return jsonData
  }

  private func url(_ url: URL, withQuery queryItems: [String: Encodable]) -> URL? {
    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
    urlComponents?.queryItems = queryItems.map { key, value in
      let valueString = String(describing: value)
      return URLQueryItem(name: key, value: valueString)
    }
    return urlComponents?.url
  }
}
