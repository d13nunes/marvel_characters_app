//
//  Dialogs.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 23/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import  UIKit

class Dialogs {
    init() {
        fatalError("Dialogs is intended to be a static class")
    }
    
    static func errorDailog(errorMessage message: String) -> UIViewController {
        let alerDialog = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        alerDialog.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alerDialog
    }
}
