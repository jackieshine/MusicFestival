//
//  FestivalAPIRequest.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import Foundation

/// API Request to fetch festival.
final class FestivalAPIRequest: APIRequest {
  // MARK: - Properties
  var appConfigurationClient: AppConfigurationProviding
  var path: String { "api/v1/festivals" }

  // MARK: - Life Cycle
  init(appConfigurationClient: AppConfigurationProviding = AppConfigurationClient()) {
    self.appConfigurationClient = appConfigurationClient
  }
}
