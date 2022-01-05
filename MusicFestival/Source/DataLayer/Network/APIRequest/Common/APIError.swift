//
//  APIError.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import Foundation

/// Base protocol for api error. Any error object should implement it so that the APIErrorCreator could return it.
protocol APIError: Decodable {}

/// Error object for `429` as per spec.
extension String: APIError {}

/// Protocol to create `APIError` object according to error data.
protocol APIErrorCreatorProtocol {
  /// Decodes error from Data type to APIError.
  /// - Parameters:
  ///   - fromData data: Error in `Data` type.
  /// - Returns: APIError object.
  func decodeAPIError(fromData data: Data?) -> APIError?
}

struct APIErrorCreator: APIErrorCreatorProtocol {
  func decodeAPIError(fromData data: Data?) -> APIError? {
    guard let data = data else { return nil }
    return String(data: data, encoding: .utf8)
  }
}
