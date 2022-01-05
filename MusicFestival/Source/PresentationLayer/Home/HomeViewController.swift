//
//  ViewController.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import UIKit

final class HomeViewController: UIViewController {
  // MARK: - Properties

  private let tableView = UITableView(frame: .zero, style: .insetGrouped)
  private lazy var viewModel = HomeViewModel(display: self)

  private struct Constants {
    static let bandCellIdentifier = "BandCell"
  }

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraint()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.viewDidAppear()
  }

  // MARK: - Views Configuration

  private func setupViews() {
    view.backgroundColor = .systemBackground
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(BandCell.self, forCellReuseIdentifier: Constants.bandCellIdentifier)
    tableView.allowsSelection = false
    view.addSubview(tableView)
  }

  private func setupConstraint() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    let tableViewConstraints = [tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)]
    NSLayoutConstraint.activate(tableViewConstraints)
  }
}

// MARK: - UITableView Conformance

extension HomeViewController: UITableViewProvider {
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    "Record Label: \(viewModel.recordLabels[section].name)"
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    viewModel.recordLabels.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.recordLabels[section].bands.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.bandCellIdentifier) as? BandCell else {
      fatalError("Unable to Dequeue Reusable Table View Cell with identifier \(Constants.bandCellIdentifier)")
    }
    let band = viewModel.recordLabels[indexPath.section].bands[indexPath.row]
    cell.configure(title: band.name, festivals: band.attendedFestivals)
    return cell
  }
}

// MARK: - Display Conformance

extension HomeViewController: HomeDisplay {
  func reloadTableView() {
    tableView.reloadData()
  }
}
