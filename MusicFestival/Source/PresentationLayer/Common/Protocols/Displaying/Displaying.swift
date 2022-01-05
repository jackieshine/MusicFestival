//
//  Displaying.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import UIKit

typealias UITableViewProvider = UITableViewDelegate & UITableViewDataSource
typealias AlertAction = (UIAlertAction) -> Void

/// Root Display protocol providing basic functionalities.
protocol Displaying: AnyObject {}

protocol DisplayErrorViewCapable {
  func showGenericError(with handler: @escaping AlertAction)
}

extension DisplayErrorViewCapable where Self: UIViewController {
  func showGenericError(with handler: @escaping AlertAction) {
    let alert = UIAlertController(title: "Oops", message: "Something went wrong. Please try again.", preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Retry",
                                    style: .default,
                                    handler: handler)
    alert.addAction(alertAction)
    present(alert, animated: true, completion: nil)
  }
}
