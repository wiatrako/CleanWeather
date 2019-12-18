//
//  CityListInteractor.swift
//  CleanWeather
//
//  Created by Marek Skrzelowski on 12/11/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Foundation

protocol CityListInteractor {
    func getFavouriteCities()
    func getCitiesWeather()
    func didSelectCityCell(id: String)
    func didPressAddButton()

}

final class CityListInteractorImpl {

    private var favouriteCities = [City]()
    private var cityWeather = [CityWeather]()
    
    private let presenter: CityListPresenter
    private let worker: CityListWorker
    private let router: CityListRouter
    
    init(presenter: CityListPresenter,
         worker: CityListWorker,
         router: CityListRouter) {
        self.presenter = presenter
        self.worker = worker
        self.router = router
    }
}

extension CityListInteractorImpl: CityListInteractor {

    func getFavouriteCities() {
        presenter.toggleSpinner(true)
        worker.fetchFavouriteCities { [weak self] result in
            self?.presenter.toggleSpinner(false)
            switch result {
            case .success(let favourites):
                guard let self = self else { return }
                self.favouriteCities = favourites

                //TODO: To be rebuild when proper networking for getCitiesWeather will be added
                let temporaryConversion = favourites.map { CityWeather(id: $0.id, city: $0.name, temperature: 13, icon: "partly-cloudy-day")}

                self.presenter.presentCitiesWeather(citiesWeather: temporaryConversion)
            case .failure(let error):
                self?.presenter.presentError(error)
            }
        }
    }

    //TODO: To be rebuild when proper networking for getCitiesWeather will be added
    func getCitiesWeather() {
        presenter.toggleSpinner(true)
        worker.fetchCityWeather { [weak self] result in
            self?.presenter.toggleSpinner(false)
            switch result {
            case .success(let city):
                self?.cityWeather = city
                self?.presenter.presentCitiesWeather(citiesWeather: city)
            case .failure(let error):
                self?.presenter.presentError(error)
            }
        }
    }
    
    func didSelectCityCell(id: String) {
        guard let weather = cityWeather.first(where: { $0.id == id }) else { return }
        router.navigateToCityForecast(cityWeather: weather)
    }

    func didPressAddButton() {
        router.navigateToFavouriteCities()
    }
}
