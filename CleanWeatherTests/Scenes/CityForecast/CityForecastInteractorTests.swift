//
//  CityForecastInteractorTests.swift
//  CleanWeatherTests
//
//  Created by Marek Skrzelowski on 22/11/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Quick
import Nimble

@testable import CleanWeather

final class CityForecastInteractorTests: QuickSpec {

    override func spec() {

        var presenter: FakeCityForecastPresenter!
        var worker: FakeCityForecastWorker!
        var router: FakeCityForecastRouter!
        var interactor: CityForecastInteractorImpl!

        beforeEach {
            presenter = FakeCityForecastPresenter()
            worker = FakeCityForecastWorker()
            router = FakeCityForecastRouter()
            interactor = CityForecastInteractorImpl(cityDetails: Mock.cityWeather2,
                                                    presenter: presenter,
                                                    worker: worker,
                                                    router: router)
        }

        describe("getting city details") {

            beforeEach {
                interactor.getCityDetails()
            }

            it("should call presenter to display valid city details") {
                expect(presenter.presentCityDetailsCalled?.city).to(equal(Mock.cityWeather2.city))
            }
        }

        describe("getting city forecast") {

            beforeEach {
                interactor.getCityForecast()
            }

            it("should call presenter to show spinner") {
                expect(presenter.toggleSpinnerStateCalled).to(beTrue())
            }

            it("should call worker to fetch city hourly details list for valid coordinates") {
                expect(worker.fetchCityHourDetailsListCalled).to(beTrue())
                expect(worker.fetchCityHourDetailsListCoordinatesCalled).to(equal("40.0,5.0"))
            }

            context("on success response") {

                beforeEach {
                    worker.fetchCityHourDetailsListCompletion?(.success(Mock.cityForecast))
                }

                it("should call presenter to hide spinner") {
                    expect(presenter.toggleSpinnerStateCalled).to(beFalse())
                }

                it("should call presenter to display hourly city details list") {
                    expect(presenter.presentCityDetailsListCalled).notTo(beNil())
                    expect(presenter.presentCityDetailsListCalled?.count).to(equal(Mock.cityForecast.count))
                }

                it("should not call presenter to display any alert") {
                    expect(presenter.presentAlertTitleCalled).to(beNil())
                    expect(presenter.presentAlertMessageCalled).to(beNil())
                    expect(presenter.presentErrorCalled).to(beNil())
                }
            }

            context("on failure response") {

                beforeEach {
                    worker.fetchCityHourDetailsListCompletion?(.failure(UnitTestError()))
                }

                it("should call presenter to hide spinner") {
                    expect(presenter.toggleSpinnerStateCalled).to(beFalse())
                }

                it("should call presenter to display error") {
                    expect(presenter.presentErrorCalled).to(beAKindOf(UnitTestError.self))
                }
            }
        }

        describe("pressing history button") {

            beforeEach {
                interactor.didPressHistoryButton()
            }

            it("should call router to navigate to city historical scene") {
                expect(router.navigateToCityHistoricalCityWeatherCalled?.city).to(equal(Mock.cityWeather2.city))
            }
        }
    }
}
