//
//  HomeViewModel.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

protocol HomeDisplay: Displaying, DisplayErrorViewCapable {
  func reloadTableView()
}

/// ViewModel for HomeViewController.
final class HomeViewModel {
  // MARK: - Properties

  private weak var display: HomeDisplay?
  private var festivalService: FestivalUseCase

  /// Data source for table view in HomeViewController
  var recordLabels: [RecordLabel] = [] {
    didSet {
      display?.reloadTableView()
    }
  }

  // MARK: - Life Cycle

  init(display: HomeDisplay, festivalService: FestivalUseCase = FestivalService()) {
    self.display = display
    self.festivalService = festivalService
  }

  func viewDidAppear() {
    festivalService.getRecordLabels { [weak self] result in
      switch result {
      case .success(let recordLabels):
        self?.recordLabels = recordLabels
      case .failure:
        self?.display?.showGenericError(with: { [weak self]_ in
          self?.viewDidAppear()
        })
      }
    }
  }
}
