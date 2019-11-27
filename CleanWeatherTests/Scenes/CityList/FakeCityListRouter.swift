//
//  FakeCityListRouter.swift
//  CleanWeatherTests
//
//  Created by Marek Skrzelowski on 25/11/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

@testable import CleanWeather

final class FakeCityListRouter: CityListRouter {

    var navigateToCityForecastCityWeatherCalled: CityWeather?

    func navigateToCityForecast(cityWeather: CityWeather) {
        navigateToCityForecastCityWeatherCalled = cityWeather
    }
}
