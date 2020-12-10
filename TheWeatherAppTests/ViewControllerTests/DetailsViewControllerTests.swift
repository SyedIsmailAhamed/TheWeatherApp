//
//  DetailsViewControllerTests.swift
//  TheWeatherAppTests
//
//  Created by OSE on 12/10/20.
//

import XCTest

class DetailsViewControllerTests: XCTestCase {

    var viewControllerUnderTest : DetailsViewController!

    override func setUp() {
        viewControllerUnderTest = DetailsViewController()
        //load view hierarchy
        if(viewControllerUnderTest != nil) {
            viewControllerUnderTest.loadView()
            viewControllerUnderTest.viewDidLoad()
        }
    }
    override func tearDown() {
        viewControllerUnderTest = nil
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

    func testControllerConformsToTableViewDelegate() {
        XCTAssert(viewControllerUnderTest.conforms(to: UITableViewDelegate.self), "ViewController under test  does not conform to UITableViewDelegate protocol")
    }
    func testControllerConformsToTableViewDataSource() {
        XCTAssert(viewControllerUnderTest.conforms(to: UITableViewDataSource.self),"ViewController under test  does not conform to UITableViewDataSource protocol")
    }

}
