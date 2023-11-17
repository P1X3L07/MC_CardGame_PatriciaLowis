//
//  AFL2_Card_Game_Patricia_LowisUITestsLaunchTests.swift
//  AFL2_Card Game_Patricia LowisUITests
//
//  Created by MacBook Pro on 15/11/23.
//

import XCTest

final class AFL2_Card_Game_Patricia_LowisUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
