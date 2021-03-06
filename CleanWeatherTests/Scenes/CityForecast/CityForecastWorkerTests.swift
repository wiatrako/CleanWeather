//
//  CityForecastWorkerTests.swift
//  CleanWeatherTests
//
//  Created by Marek Skrzelowski on 22/11/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Quick
import Nimble

@testable import CleanWeather

final class CityForecastWorkerTests: QuickSpec {

    override func spec() {

        var networking: FakeWeatherNetworking!
        var worker: CityForecastWorkerImpl!

        beforeEach {
            networking = FakeWeatherNetworking()
            worker = CityForecastWorkerImpl(networking: networking)
        }

        describe("fetching city hour details list") {

            var receivedCityHourDetailsList: [CityForecast]?
            var receivedError: Error?

            beforeEach {
                worker.fetchCityHourlyForecast(coordinates: Mock.cityWeather2.id) { result in
                    switch result {
                    case .success(let cityHourForecast):
                        receivedCityHourDetailsList = cityHourForecast
                    case .failure(let error):
                        receivedError = error
                    }
                }
            }

            afterEach {
                receivedCityHourDetailsList = nil
                receivedError = nil
            }

            it("should call networking to fetch city hour details list for valid id") {
                expect(networking.fetchForecastWeatherForCityCalled).to(beTrue())
                expect(networking.fetchForecastWeatherForCityCoordinatesCalled).to(equal(Mock.cityWeather2.id))
            }

            context("on success response") {

                beforeEach {
                    networking.fetchForecastWeatherForCityCompletion?(.success(Mock.CityForecastApiResponse))
                }

                it("should return city hour details list") {
                    expect(receivedCityHourDetailsList).notTo(beNil())
                    expect(receivedCityHourDetailsList?.count).to(equal(Mock.CityForecastApiResponse.hourly.data.count))
                }

                it("should return no errors") {
                    expect(receivedError).to(beNil())
                }
            }

            context("on failure response") {

                beforeEach {
                    networking.fetchForecastWeatherForCityCompletion?(.failure(UnitTestError()))
                }

                it("should not return city hour details list") {
                    expect(receivedCityHourDetailsList).to(beNil())
                }

                it("should return valid error") {
                    expect(receivedError).to(beAKindOf(UnitTestError.self))
                }
            }
        }
    }
}
