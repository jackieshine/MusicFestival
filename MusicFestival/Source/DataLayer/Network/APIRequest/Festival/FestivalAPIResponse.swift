//
//  FestivalAPIResponse.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import Foundation

/// Single object of FestivalAPIClient when succeeded.
struct MusicFestival: Decodable {
  let name: String?
  let bands: [Band]
}

extension MusicFestival {
  struct Band: Decodable {
    let name: String?
    let recordLabel: String?
  }
}
