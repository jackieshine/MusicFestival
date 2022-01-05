//
//  AppConfigurationClient.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import Foundation

/// Provides the values for the app's configuration.
protocol AppConfigurationProviding {

  /// The api timeout interval.
  var apiTimeout: TimeInterval { get }

  /// The extended api timeout interval.
  var apiExtendedTimeout: TimeInterval { get }

  /// The api end point.
  var apiEndPoint: URL? { get }
}

// MARK: - AppConfigurationClient

final class AppConfigurationClient: AppConfigurationProviding {
  // MARK: - Properties

  var apiTimeout: TimeInterval { 30 }
  var apiExtendedTimeout: TimeInterval { 60 }
  var apiEndPoint: URL? { URL(string: "https://eacp.energyaustralia.com.au/codingtest/") }
}

