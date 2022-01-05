//
//  HTTPRequestMethod.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import Foundation

/// Wrapper for HTTP request methods in order to avoid 'stringly typed' usages
enum HTTPRequestMethod: String {
  /// GET method type
  case get = "GET"

  /// POST method type
  case post = "POST"

  /// PUT method type
  case put = "PUT"

  /// DELETE method type
  case delete = "DELETE"

  /// PATCH method type
  case patch = "PATCH"
}
