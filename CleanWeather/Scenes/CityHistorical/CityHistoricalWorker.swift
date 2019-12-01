//
//  CityHistoricalWorker.swift
//  CleanWeather
//
//  Created by Marek Skrzelowski on 01/12/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Foundation

protocol CityHistoricalWorker {
    func fetchCityHistoricalWeather(id: String, date: Date, completion: FetchHistoricalCompletion?)
}

final class CityHistoricalWorkerImpl {

    private let networking: WeatherNetworking

    init(networking: WeatherNetworking) {
        self.networking = networking
    }
}

extension CityHistoricalWorkerImpl: CityHistoricalWorker {

    func fetchCityHistoricalWeather(id: String, date: Date, completion: FetchHistoricalCompletion?) {
        networking.fetchHistoricalWeatherForCity(id: id, date: date, completion: completion)
    }
}
