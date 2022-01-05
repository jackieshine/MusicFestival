//
//  HTTPStatusCode.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import Foundation

/// Represents HTTP request status code.
enum HTTPStatusCode: Int, CaseIterable {
  /// `200 Success`.
  case success = 200

  /// `302 Redirect`
  case redirect = 302

  /// `400 Bad request`.
  case badRequest = 400

  /// `401 Unauthorized`.
  case unAuthorized = 401

  /// `403 otpChallenge`.
  case otpChallenge = 403

  /// `404 Not found`.
  case notFound = 404

  /// `429 Too many requests`.
  case tooManyRequests = 429

  /// `450` is an error code used by our middleware/gateway to indicate that a downstream system returned 400.
  case badRequestDownstream = 450

  /// `451 Unavailable For Legal Reasons`.
  case unavailableForLegalReasons = 451

  /// `453` Custom status code from Boomi middleware which equals status code `403`.
  case middleware453 = 453

  /// `454` Custom status code from Boomi middleware which equals status code `404`.
  case middleware454 = 454

  /// `500 Internal server error`.
  case internalServerError = 500

  /// `503 Server unavailable`.
  case serverUnavailable = 503

  /// `550` Custom status code from Boomi middleware which equals status code `500`.
  case middleware550 = 550

  /// Undefined HTTP status code.
  case undefined = -1

  // MARK: - Initialisation

  init(rawValue: Int) {
    switch rawValue {
    case 200 ... 299:
      self = .success
    default:
      let statusCode = HTTPStatusCode.allCases.first(where: { $0.rawValue == rawValue })
      self = statusCode ?? .undefined
    }
  }
}
