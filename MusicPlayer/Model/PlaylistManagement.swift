//
//  PlaylistManagement.swift
//  MusicPlayer
//
//  Created by Firman Aminuddin on 9/2/21.
//

import UIKit
import AVFoundation

struct PLAYLIST {
    let imageName : String
    let songName : String
    let artistName : String
    let albumName : String
    let previewURL : String
    var isPlay : Bool
}

final class PlaylistManagement{
    static let shared = PlaylistManagement()
    var player: AVPlayer!
    var songTime: Timer?
    
    func initSong(url : String){
        let url = URL.init(string: url)
        player = AVPlayer.init(url: url!)
    }
    
    func playSong(){
        player.play()
    }
    
    func pauseSong(){
        player.pause()
    }
}
