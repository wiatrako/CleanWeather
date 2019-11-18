//
//  CityListPresenter.swift
//  CleanWeather
//
//  Created by Marek Skrzelowski on 12/11/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import UIKit

protocol CityListPresenter: SharedPresenter {
    func displayCitiesWeather(citiesWeather: [CityWeather])
}

final class CityListPresenterImpl: SharedPresenter {
    
//    weak var controller: CityListPresentable?
    
}

extension CityListPresenterImpl: CityListPresenter {
    
    func displayCitiesWeather(citiesWeather: [CityWeather]) {
        let displayable = citiesWeather.map { CityWeatherDisplayable(object: $0)}
        controller?.displayCity(displayable)
    }
}
