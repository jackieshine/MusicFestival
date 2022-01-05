//
//  BandCellViewModel.swift
//  MusicFestival
//
//  Created by Jackie on 2/1/22.
//

import Foundation

protocol BandCellDisplay: Displaying {
  func reloadTableView()
}

final class BandCellViewModel {
  // MARK: - Properties

  private weak var display: BandCellDisplay?
  var festivals: [String] = [] {
    didSet {
      display?.reloadTableView()
    }
  }

  init(display: BandCellDisplay) {
    self.display = display
  }
}
