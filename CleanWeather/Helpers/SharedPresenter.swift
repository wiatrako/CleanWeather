//
//  SharedPresenter.swift
//  CleanWeather
//
//  Created by Marek Skrzelowski on 18/11/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import UIKit

class SharedPresenter {
    
    weak var controller: CityListPresentable?
    
    func displayError(_ error: Error) {
        controller?.presentAlert(title: "Error", message: error.userFriendlyMessage)
    }
    
    func showSpinner(_ state: Bool) {
        controller?.presentSpinner(state)
    }
}