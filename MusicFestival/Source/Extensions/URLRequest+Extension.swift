//
//  URLRequest+Extension.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import Foundation

extension URLRequest {
  /// Set header fields of the request.
  /// If a value was previously set for the given header
  /// field, that value is replaced with the given value.
  ///
  /// - Parameter header: Dictionary of header field keys and values.
  public mutating func setHeader(_ header: [String: String]) {
    for (key, value) in header {
      setValue(value, forHTTPHeaderField: key)
    }
  }

  /// Add header fields to the request.
  /// If a value was previously set for the given
  /// header field, the given value is appended to the previously-existing
  /// value.
  ///
  /// - Parameter header: Dictionary of header field keys and values.
  public mutating func addHeader(_ header: [String: String]) {
    for (key, value) in header {
      addValue(value, forHTTPHeaderField: key)
    }
  }
}
