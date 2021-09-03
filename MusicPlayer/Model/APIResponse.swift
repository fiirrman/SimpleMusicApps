//
//  APIResponse.swift
//  MusicPlayer
//
//  Created by Firman Aminuddin on 9/3/21.
//

import Foundation

// MARK: SEARCH ARTSIT
struct ResponseResult : Codable{
    let results : [ResponseByArtist]
}

struct ResponseByArtist : Codable{
    let artistName : String // Artist name
    let trackName : String // Song title
    let collectionName : String // Album name
    let artworkUrl100 : String // Cover Album
    let previewUrl : String // Preview song
}

