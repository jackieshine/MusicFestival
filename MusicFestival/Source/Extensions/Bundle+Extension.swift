//
//  Bundle+Extension.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import Foundation

extension Bundle {
  /// Read JSON data from file.
  ///
  /// - Parameter resource: Path to the JSON file.
  /// - Returns: JSON data read from the `resource` file. `nil` otherwise.
  func jsonData(fromResource resource: String) -> Data? {
    guard let resourceURL = url(forResource: resource, withExtension: "json") else {
      return nil
    }
    let data = try? Data(contentsOf: resourceURL)
    return data
  }
}
