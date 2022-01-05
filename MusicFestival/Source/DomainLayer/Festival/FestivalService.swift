//
//  FestivalService.swift
//  MusicFestival
//
//  Created by Jackie on 31/12/21.
//

import Foundation

/// Procotol describing festival service behaviour.
protocol FestivalUseCase {
  /// Gets `[RecordLabel]`.
  ///
  ///   - Parameters:
  ///     - completion: Completion handler for the api call.
  func getRecordLabels(completion: @escaping (Result<[RecordLabel], NetworkError>) -> Void)
}

final class FestivalService: FestivalUseCase {
  // MARK: - Properties

  private let festivalAPIClient: FestivalAPIObjectProviding

  // MARK: - Life Cycle

  init(festivalAPIClient: FestivalAPIObjectProviding = FestivalAPIClient()) {
    self.festivalAPIClient = festivalAPIClient
  }

  // MARK: - FestivalUseCase Conformance

  func getRecordLabels(completion: @escaping (Result<[RecordLabel], NetworkError>) -> Void) {
    festivalAPIClient.getFestivals { [weak self] musicFestivals in
      let recordLabels = self?.getRecordLabels(from: musicFestivals)
      completion(.success(recordLabels ?? []))
    } failure: { error in
      completion(.failure(error))
    }
  }

  private func getRecordLabels(from musicFestivals: [MusicFestival]) -> [RecordLabel] {
    var festivalDict = [String: [String: [String]]]()
    for festival in musicFestivals {
      for band in festival.bands {
        let label = band.recordLabel ?? ""
        if let recordLabelDict = festivalDict[label] {
          if recordLabelDict[band.name ?? ""] != nil {
            festivalDict[label]?[band.name ?? ""]?.append(festival.name ?? "")
          } else {
            festivalDict[label]?[band.name ?? ""] = [String]()
            festivalDict[label]?[band.name ?? ""]?.append(festival.name ?? "")
          }
        } else {
          festivalDict[label] = [String: [String]]()
          festivalDict[label]?[band.name ?? ""] = [String]()
          festivalDict[label]?[band.name ?? ""]?.append(festival.name ?? "")
        }
      }
    }
    var recordLabels: [RecordLabel] = festivalDict.map { RecordLabel(name: $0.key, bands: $0.value)}
    recordLabels.sort { $0.name.uppercased() < $1.name.uppercased() }
    return recordLabels
  }
}
