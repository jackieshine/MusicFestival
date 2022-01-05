//
//  FestivalAPIClient.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import Foundation

/// Action to be invoked when Festival API call succeeded.
///
///  - Parameters:
///     - festivals: `[MusicFestival]` model.
typealias FestivalAPISuccessAction = (_ festivals: [MusicFestival]) -> Void

/// Action to be invoked when Festival API call failed.
///
/// - Parameters:
///   - error: `NetworkError` model
typealias FestivalAPIFailureAction = (_ error: NetworkError) -> Void

/// Provides functionalities to fetch FestivalAPIResponse Object
protocol FestivalAPIObjectProviding: APIClientProviding {
  /// Fetches FestivalAPIResponse Object
  ///   - Parameters:
  ///     - success: `FestivalAPISuccessAction`
  ///     - failure: `FestivalAPIFailureAction`
  func getFestivals(success: @escaping FestivalAPISuccessAction,
                    failure: @escaping FestivalAPIFailureAction)
}

final class FestivalAPIClient: FestivalAPIObjectProviding {
  // MARK: - Properties

  var httpClient: HTTPRequestMaking

  // MARK: - Life Cycle

  init(httpClient: HTTPRequestMaking = HTTPClient()) {
    self.httpClient = httpClient
  }

  // MARK: - FestivalAPIObjectProviding Conformance

  func getFestivals(success: @escaping FestivalAPISuccessAction,
                    failure: @escaping FestivalAPIFailureAction) {
    let request = FestivalAPIRequest()
    httpClient.send(request,
                    success: success,
                    failure: failure)
  }
}
