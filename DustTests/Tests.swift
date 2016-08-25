//
//  Tests.swift
//  Dust
//
//  Created by Khoa Pham on 23/08/16.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import XCTest
import Dust

class Tests: XCTestCase {

  override func setUp() {
    super.setUp()

    OneSignal.appID = "78610b70-edc6-4c61-ad5d-45083b6d3361"
  }

  func testRegister() {
    let expectation = self.expectationWithDescription("test")

    OneSignal.registerUser() { playerID in
      XCTAssertNotNil(playerID)
      expectation.fulfill()
    }

    self.waitForExpectationsWithTimeout(5.0, handler: nil)
  }

}
