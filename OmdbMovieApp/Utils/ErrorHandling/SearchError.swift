//
//  Progress.swift
//  OmdbMovieApp
//
//  Created by Selcuk on 21.03.2022.
//

import Foundation
import UIKit


//- MARK: When Movies return nil, show error message.
protocol AlertDisplaying {
    func displayAlert(title: String, message: String)
}
extension AlertDisplaying where Self: UIViewController {
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonAction = (UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        alertController.addAction(buttonAction)
        present(alertController, animated: true, completion: nil)
    }
}




