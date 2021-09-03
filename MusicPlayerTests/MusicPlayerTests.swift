//
//  MusicPlayerTests.swift
//  MusicPlayerTests
//
//  Created by Firman Aminuddin on 8/20/21.
//

import XCTest
@testable import MusicPlayer

class MusicPlayerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // TEST API OK
        let query = "term=katy&limit=10"
        NetworkManager.fetchList(query: query, vc: UIViewController(), completion: { result in
            print(result.count)
            
            // API OK
            XCTAssert(result.count > 0)
            
            if result.count > 0 {
                // TEST CREATE SONG
                XCTAssertNil(PlaylistManagement.shared.initSong(url: result[0].previewURL))
                
                // TEST PLAY SONG
                XCTAssertNil(PlaylistManagement.shared.playSong())
                
                // TEST PAUSE SONG
                XCTAssertNil(PlaylistManagement.shared.pauseSong())
            }
        })
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
