//
//  FestivalCell.swift
//  MusicFestival
//
//  Created by Jackie on 2/1/22.
//

import UIKit

final class FestivalCell: UITableViewCell {
  // MARK: - Properties

  private let contentLabel = UILabel()
  private struct Constant {
    struct Padding {
      static let top: CGFloat = 5
      static let leading: CGFloat = 20
      static let bottom: CGFloat = -5
      static let trailing: CGFloat = 0
    }
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
    setupConstraint()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupView() {
    addSubview(contentLabel)
    contentLabel.translatesAutoresizingMaskIntoConstraints = false
    contentLabel.font = .systemFont(ofSize: 15)
  }

  private func setupConstraint() {
    typealias Padding = Constant.Padding
    let contentLabelConstraints = [contentLabel.topAnchor.constraint(equalTo: topAnchor, constant: Padding.top),
                                   contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.leading),
                                   contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Padding.bottom),
                                   contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.trailing)]
    NSLayoutConstraint.activate(contentLabelConstraints)
  }

  func configure(content: String) {
    contentLabel.text = content
  }
}
