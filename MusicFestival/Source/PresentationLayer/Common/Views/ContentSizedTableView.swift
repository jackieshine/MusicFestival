//
//  ContentSizedTableView.swift
//  MusicFestival
//
//  Created by Jackie on 2/1/22.
//

import UIKit

/// This Table View will update the height according to the content height.
final class ContentSizedTableView: UITableView {
  override var contentSize:CGSize {
    didSet {
        invalidateIntrinsicContentSize()
    }
  }

  override var intrinsicContentSize: CGSize {
    layoutIfNeeded()
    return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
  }
}
