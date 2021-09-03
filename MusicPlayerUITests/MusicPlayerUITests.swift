//
//  MusicPlayerUITests.swift
//  MusicPlayerUITests
//
//  Created by Firman Aminuddin on 8/20/21.
//

import XCTest

class MusicPlayerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        
        // TAP TO SEARCH FIELD
        let searchArtistSongAlbumTextField = app.textFields["Search artist, song, album..."]
        searchArtistSongAlbumTextField.tap()
        
        // CHOOSE SONG
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Dark Horse (feat. Juicy J)"]/*[[".cells.staticTexts[\"Dark Horse (feat. Juicy J)\"]",".staticTexts[\"Dark Horse (feat. Juicy J)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // PLAY SONG
        let playButton = app.buttons["play"]
        playButton.tap()
        
        // PAUSE SONG
        app.buttons["pause"].tap()
        playButton.tap()
        
        // TAP NEXT SONG
        app.buttons["forward.end"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 1).tap()
        
        // TAP PREVIOUS SONG
        app.buttons["backward.end"].tap()
        
        // CHOOSE OTHER SONG
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Roar"]/*[[".cells.staticTexts[\"Roar\"]",".staticTexts[\"Roar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        searchArtistSongAlbumTextField.tap()
        searchArtistSongAlbumTextField.tap()
        tablesQuery.cells.containing(.staticText, identifier:"The Lost World: Jurassic Park").staticTexts["Jurassic Park Collection"].swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Get On Your Knees (feat. Ariana Grande)"]/*[[".cells.staticTexts[\"Get On Your Knees (feat. Ariana Grande)\"]",".staticTexts[\"Get On Your Knees (feat. Ariana Grande)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Tolong - Single"]/*[[".cells.staticTexts[\"Tolong - Single\"]",".staticTexts[\"Tolong - Single\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.cells.containing(.staticText, identifier:"Suka Semua").staticTexts["1 Hari Yang Cerah"].swipeUp()
        tablesQuery.cells.containing(.staticText, identifier:"Asmara Nusantara").staticTexts["1 Hari Yang Cerah"].swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Melukis Senja - Single"]/*[[".cells.staticTexts[\"Melukis Senja - Single\"]",".staticTexts[\"Melukis Senja - Single\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        searchArtistSongAlbumTextField.tap()
        searchArtistSongAlbumTextField.tap()
        tablesQuery.cells.containing(.staticText, identifier:"Doremi").element.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Tolong"]/*[[".cells.staticTexts[\"Tolong\"]",".staticTexts[\"Tolong\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
