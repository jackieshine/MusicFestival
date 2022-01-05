//
//  HTTPClient.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import Foundation

// MARK: - API Client

/// Protocol describing all api clients
protocol APIClientProviding {
  /// HTTPClient to invoke api calls.
  var httpClient: HTTPRequestMaking { get }

  /// Cancels all request in the queue.
  func cancelRequests()
}

extension APIClientProviding {
  func cancelRequests() {
    httpClient.cancelRequests()
  }
}

// MARK: - HTTP Client

/// Closure to be envoked when data is returned from making the HTTP request.
///
/// - Parameters:
///   - data: Data returned from making the HTTP request.
typealias HTTPRequestSuccessAction<T> = (_ data: T) -> Void

/// Closure to be envoked shall error raises by making the HTTP request.
///
/// - Parameters:
///   - error: Error from making the HTTP request.
typealias HTTPRequestFailureAction = (_ error: NetworkError) -> Void

/// Protocol defining the ability make HTTP requests and receive responses.
protocol HTTPRequestMaking {
  /// Send method call.
  ///
  /// - Parameters:
  ///   - request: An instance of `APIRequest`.
  ///   - success: Closure to be envoked when data is returned from HTTP request.
  ///   - failure: Closure to be envoked if error happened with making HTTP request.
  func send<T: Decodable>(_ request: APIRequest,
                          success: @escaping HTTPRequestSuccessAction<T>,
                          failure: @escaping HTTPRequestFailureAction)

  /// Send method call.
  /// 
  /// - Parameters:
  ///   - request: An instance of `APIRequest`.
  ///   - callbackQueue: The queue that the client should return the completionHandler on. Defaults to `DispatchQueue.main`.
  ///   - success: Closure to be envoked when data is returned from HTTP request.
  ///   - failure: Closure to be envoked if error happened with making HTTP request.
  func send<T: Decodable>(_ request: APIRequest,
                          callbackQueue: DispatchQueue,
                          success: @escaping HTTPRequestSuccessAction<T>,
                          failure: @escaping HTTPRequestFailureAction)

  /// Cancels any requests that are currently being made by the `HTTPClient`.
  func cancelRequests()
}

/// Provides functionalities to send HTTP requests and receive reponses.
final class HTTPClient: NSObject, HTTPRequestMaking {
  // MARK: - Properties

  private let session: URLSession
  private let apiErrorDecoder: APIErrorCreatorProtocol
  private var currentSessionTasks: [URLSessionTask] = []
  private let appConfiguration: AppConfigurationProviding

  // MARK: - Life Cycle

  init(useExtendedTimeout: Bool = false,
       apiErrorDecoder: APIErrorCreatorProtocol = APIErrorCreator(),
       appConfiguration: AppConfigurationProviding = AppConfigurationClient()) {
    let configuration = URLSessionConfiguration.ephemeral

    let timeout = useExtendedTimeout ? appConfiguration.apiExtendedTimeout : appConfiguration.apiTimeout
    configuration.timeoutIntervalForRequest = timeout

    self.session = URLSession(configuration: configuration)
    self.apiErrorDecoder = apiErrorDecoder
    self.appConfiguration = appConfiguration
  }

  // MARK: - Request Execution

  func send<T: Decodable>(_ request: APIRequest,
                          success: @escaping HTTPRequestSuccessAction<T>,
                          failure: @escaping HTTPRequestFailureAction) {
    send(request,
         callbackQueue: .main,
         success: success,
         failure: failure)
  }

  func send<T: Decodable>(_ request: APIRequest,
                          callbackQueue: DispatchQueue,
                          success: @escaping HTTPRequestSuccessAction<T>,
                          failure: @escaping HTTPRequestFailureAction) {
    guard let urlRequest = request.asURLRequest() else {
      failure(.malformedRequest(request: request))
      return
    }

    cancelRequests()

    let sessionTask = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
      if let error = self.parseNetworkErrors(fromResponse: response,
                                             withData: data,
                                             error: error) {
        callbackQueue.async {
          failure(error)
        }
        return
      }

      guard let data = data else {
        callbackQueue.async {
          failure(.successWithNoData)
        }
        return
      }

      do {
        let value: T = try self.parseResponse(fromData: data)
        callbackQueue.async {
          success(value)
        }
      } catch {
        callbackQueue.async {
          failure(.uninterpretableResponse)
        }
      }
    }

    sessionTask.resume()
    currentSessionTasks.append(sessionTask)
  }

  // MARK: - Request Parsing

  private func parseNetworkErrors(fromResponse response: URLResponse?,
                          withData data: Data?,
                          error: Error?) -> NetworkError? {
    if let error = error {
      return NetworkError(error)
    }

    guard let response = response as? HTTPURLResponse else {
      return .undefined(error: nil)
    }

    if HTTPStatusCode(rawValue: response.statusCode) != .success {
      let statusCode = HTTPStatusCode(rawValue: response.statusCode)
      let apiError = apiErrorDecoder.decodeAPIError(fromData: data)
      let error = NetworkError.badRequest(withStatusCode: statusCode, responseError: apiError)
      return error
    }

    return nil
  }

  private func parseResponse<T: Decodable>(fromData data: Data) throws -> T {
    // If we are expecting a raw `Data` response then we cannot decode it and should just pass it
    // up, as is, to the calling function.
    if T.self == Data.self,
      let responseData = data as? T {
      return responseData
    }

    let decoder = JSONDecoder()
    let value = try decoder.decode(T.self, from: data)
    return value
  }

  // MARK: - Request Cancellation

  func cancelRequests() {
    for task in currentSessionTasks {
      task.cancel()
    }
    currentSessionTasks.removeAll()
  }
}
