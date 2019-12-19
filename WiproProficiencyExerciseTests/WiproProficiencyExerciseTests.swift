//
//  WiproProficiencyExerciseTests.swift
//  WiproProficiencyExerciseTests
//
//  Created by Kalyan Mannem on 12/12/19.
//  Copyright © 2019 CompIndia. All rights reserved.
//

import XCTest
@testable import WiproProficiencyExercise

class WiproProficiencyExerciseTests: XCTestCase {

    let viewModel = CanadaViewModel()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testAPIWorking()
    {

        let expectation = XCTestExpectation.init(description: "Wait for api")

        viewModel.getCanadaDetails(url: AppConstants.SERVICE_URL) { (result) in
            switch result {
            case .success( _):
                expectation.fulfill()
            case .failure( _):
                XCTFail("failed")
            }
        }
        self.wait(for: [expectation], timeout: 20)
    }
    
    func testJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "Wipro", withExtension: "json") else {
            XCTFail("Missing file: Wipro.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        let model: CanadaDataModel = try  JSONDecoder().decode(CanadaDataModel.self, from: json)
        
        XCTAssertEqual(model.title, "About Canada")
        XCTAssertTrue(model.rows.count>0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
