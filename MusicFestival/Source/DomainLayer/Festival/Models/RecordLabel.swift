//
//  RecordLabel.swift
//  MusicFestival
//
//  Created by Jackie on 31/12/21.
//

import Foundation

/// The object that is to be display in festival screen. Bands and the attendedFestivals would be sorted alphabetically while initiating.
struct RecordLabel {
  let name: String
  var bands: [Band]

  init(name: String, bands: [String: [String]]) {
    self.name = name
    self.bands = bands.map {
      var band = Band(name: $0.key, attendedFestivals: $0.value)
      band.attendedFestivals.sort(by: <)
      return band
    }
    self.bands.sort { $0.name < $1.name }
  }
}

extension RecordLabel {
  struct Band {
    let name: String
    var attendedFestivals: [String]
  }
}

