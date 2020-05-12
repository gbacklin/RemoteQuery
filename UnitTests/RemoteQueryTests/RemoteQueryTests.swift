//
//  RemoteQueryTests.swift
//  RemoteQueryTests
//
//  Created by Gene Backlin on 5/12/20.
//  Copyright © 2020 Gene Backlin. All rights reserved.
//

import XCTest

class RemoteQueryTests: XCTestCase {

    var query: String?
    var objects: [Person] = [Person]()
    var networkTests: NetworkTests?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        query = "http://www.ehmz.org/ajax/ajax_query.php"
        networkTests = NetworkTests()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetch() throws {
        XCTAssertNotNil(query, "query should not be nil")
        
        let expectation = self.expectation(description: "Fetching")
        networkTests?.fetchData(url: query!, completion: { (persons, error) in
            expectation.fulfill()
            XCTAssertNil(error, "Error is expected to be nil")
            XCTAssertNotNil(persons, "persons should not be nil")
            XCTAssertEqual(persons!.count, 4, "Expected person count is 4. Count returned: \(persons!.count)")
        })
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testCodeable() throws {
        measure {
            XCTAssertNotNil(query, "query should not be nil")
            
            let expectation = self.expectation(description: "Fetching")
            networkTests?.fetchData(url: query!, completion: { (persons, error) in
                expectation.fulfill()
                XCTAssertNil(error, "Error is expected to be nil")
                XCTAssertNotNil(persons, "persons should not be nil")
                XCTAssertEqual(persons!.count, 4, "Expected person count is 4. Count returned: \(persons!.count)")
                let person = persons![0]
                XCTAssertEqual(person.id, "1", "Expected person id is 1. iod returned: \(person.id)")
                XCTAssertEqual(person.Firstname, "Peter", "Expected person Firstname is Peter. Firstname returned: \(person.Firstname)")
                XCTAssertEqual(person.Age, "41", "Expected person Age is 41. Age returned: \(person.Age)")
            })
            waitForExpectations(timeout: 5, handler: nil)
        }
    }

}
