//
//  HomeViewModelTests.swift
//  TheWeatherAppTests
//
//  Created by OSE on 12/10/20.
//

import XCTest
@testable import TheWeatherApp

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockDataFetcher: MockDataFetcher!


    override func setUp() {
        mockDataFetcher = MockDataFetcher()
        mockDataFetcher.fetchMockWeatherData()
        viewModel = HomeViewModel()
        viewModel.weatherModel = mockDataFetcher.weatherModel
    }
    func testOutputAttributes() {
        XCTAssertEqual(viewModel.numberofRows() , mockDataFetcher.weatherModel.daily?.count)
    }
    func testDataModelForIndexPath() {
        let indexPath = IndexPath(row: 0, section: 1)
        let daysData = mockDataFetcher.weatherModel.daily?[indexPath.row]
        XCTAssertEqual(daysData, viewModel?.getDaysModel(idxPath: indexPath))
    }

    func testDataModelForSelectionIndexPath() {
        let indexPath = IndexPath(row: 0, section: 1)
        let selectedDay = mockDataFetcher.weatherModel.daily?[indexPath.row]
        XCTAssertEqual(selectedDay, viewModel?.getDaysModel(idxPath: indexPath))
    }
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        mockDataFetcher = nil
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class MockDataFetcher {
    var weatherModel: HomeWeather = HomeWeather()
    func fetchMockWeatherData(){
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "weather", ofType: "json") else {
            return
        }
        let jsonString = try! String(contentsOfFile: path)
        if let mockModel = HomeWeather(JSONString: jsonString){
            weatherModel = mockModel
        }
    }
}
