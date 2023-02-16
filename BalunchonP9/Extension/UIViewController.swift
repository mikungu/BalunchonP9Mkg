//
//  UIViewController.swift
//  BalunchonP9
//
//  Created by Mikungu Giresse on 05/02/23.
//

import UIKit

extension UIViewController {

    func displayAlert(title: APIError, message: String, preferredStyle: UIAlertController.Style) {
         let alertVC = UIAlertController(title: " ", message: message, preferredStyle: preferredStyle)
         alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
         present(alertVC, animated: true, completion: nil)
     }
}