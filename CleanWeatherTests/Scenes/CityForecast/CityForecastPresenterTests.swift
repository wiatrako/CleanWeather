//
//  CityForecastPresenterTests.swift
//  CleanWeatherTests
//
//  Created by Marek Skrzelowski on 22/11/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Quick
import Nimble

@testable import CleanWeather

final class CityForecastPresenterTests: QuickSpec {

    override func spec() {

        var controller: FakeCityForecastController!
        var presenter: CityForecastPresenterImpl<FakeCityForecastController>!

        beforeEach {
            controller = FakeCityForecastController()
            presenter = CityForecastPresenterImpl<FakeCityForecastController>()
            presenter.controller = controller
        }

        describe("presenting city details") {

            beforeEach {
                presenter.presentCityDetails(Mock.cityWeather3)
            }

            it("should call controller to display city details") {
                expect(controller.displayCityDetailsCalled).notTo(beNil())
                expect(controller.displayCityDetailsCalled?.name).to(equal(Mock.cityWeather3.city))
            }

            it("should display rounded temperature with degree sign") {
                expect(controller.displayCityDetailsCalled?.temp).to(equal("-10°"))
            }
        }

        describe("presenting city details list") {

            beforeEach {
                presenter.presentCityDetailsList(Mock.cityForecast)
            }

            it("should call controller to display city hourly forecast") {
                expect(controller.displayCityForecastCalled).notTo(beNil())
                expect(controller.displayCityForecastCalled?.count).to(equal(Mock.cityForecast.count))
            }

            it("should display rounded temperature with degree sign") {
                expect(controller.displayCityForecastCalled?[0].temp).to(equal("10°"))
            }

            it("should display percentage of precip with percent sign") {
                expect(controller.displayCityForecastCalled?[0].precip).to(equal("46%"))
            }
        }
    }
}
