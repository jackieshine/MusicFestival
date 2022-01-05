//
//  BandCell.swift
//  MusicFestival
//
//  Created by Jackie on 2/1/22.
//

import UIKit

/// Band cell displaying the band and the festivals contained.
final class BandCell: UITableViewCell {
  // MARK: Properties

  private struct Constant {
    struct Padding {
      struct Title {
        static let top: CGFloat = 7
        static let leading: CGFloat = 7
        static let trailing: CGFloat = -7
      }

      struct Content {
        static let top: CGFloat = 7
        static let leading: CGFloat = 7
        static let trailing: CGFloat = -7
        static let bottom: CGFloat = -7
      }
    }

    static let festivalCellIdentifier = "FestivalCell"
  }

  private lazy var viewModel: BandCellViewModel = BandCellViewModel(display: self)

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    label.text = "Band:"
    return label
  }()

  private let titleContentLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    return label
  }()

  private let festivalsTableView = ContentSizedTableView()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(titleLabel)

    titleContentLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(titleContentLabel)

    festivalsTableView.translatesAutoresizingMaskIntoConstraints = false
    festivalsTableView.dataSource = self
    festivalsTableView.delegate = self
    festivalsTableView.register(FestivalCell.self, forCellReuseIdentifier: Constant.festivalCellIdentifier)
    festivalsTableView.isScrollEnabled = false
    festivalsTableView.separatorStyle = .none
    addSubview(festivalsTableView)
  }

  private func setupConstraints() {
    typealias Padding = Constant.Padding
    let titleLabelConstraints = [titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Padding.Title.top),
                                 titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.Title.leading), titleLabel.widthAnchor.constraint(equalToConstant: 50), titleLabel.heightAnchor.constraint(equalToConstant: 25)]
    NSLayoutConstraint.activate(titleLabelConstraints)

    let titleContentLabelConstraints = [titleContentLabel.topAnchor.constraint(equalTo: topAnchor, constant: Padding.Title.top),
                                        titleContentLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Padding.Title.leading),
                                        titleContentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.Title.trailing),
                                        titleContentLabel.heightAnchor.constraint(equalToConstant: 25)]
    NSLayoutConstraint.activate(titleContentLabelConstraints)

    let festivalsTableViewConstraints = [festivalsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Padding.Content.top),
                                     festivalsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.Content.leading),
                                     festivalsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Padding.Content.bottom),
                                     festivalsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.Content.trailing)]
    NSLayoutConstraint.activate(festivalsTableViewConstraints)
  }
  
  func configure(title: String, festivals: [String]) {
    titleContentLabel.text = title
    viewModel.festivals = festivals
  }
}

extension BandCell: UITableViewProvider {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.festivalCellIdentifier) as? FestivalCell else {
      fatalError("Unable to Dequeue Reusable Table View Cell with identifier \(Constant.festivalCellIdentifier)")
    }
    cell.configure(content: viewModel.festivals[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.festivals.count
  }
}

extension BandCell: BandCellDisplay {
  func reloadTableView() {
    festivalsTableView.reloadData()
  }
}
