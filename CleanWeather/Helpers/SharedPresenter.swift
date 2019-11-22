//
//  SharedPresenter.swift
//  CleanWeather
//
//  Created by Marek Skrzelowski on 18/11/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import UIKit

class SharedPresenter<T: SpinnerPresentable & AlertPresentable>: SpinnerPresenter, AlertPresenter {
    var controller: T?
    
    func toggleSpinner(_ state: Bool) {
        controller?.toogleSpinner(state)
    }
    
    func presentAlert(title: String, message: String) {
        controller?.presentAlert(title: title, message: message)
    }
    
    func presentError(_ error: Error) {
        controller?.presentAlert(title: R.string.localizable.error(), message: error.userFriendlyMessage)
    }
}
