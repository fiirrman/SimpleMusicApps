//
//  NetworkManager.swift
//  MusicPlayer
//
//  Created by Firman Aminuddin on 9/3/21.
//

import UIKit

struct NetworkManager{
    static let baseURL = "https://itunes.apple.com"
    static let urlSearchArtist = baseURL + "/search?"
    
    static func fetchList(query : String, vc : UIViewController, completion : @escaping ([PLAYLIST]) -> Void){
        var listSong = [PLAYLIST]()
        
        let url = URL(string: NetworkManager.urlSearchArtist + query)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {(resData,res,resError) in
            
            if let err = resError{
//                print("Error accessing : \(err.localizedDescription)")
                vc.showErrorAlert(errorMsg: "Error accessing : \(err.localizedDescription)", isAction: false, title: "", typeAlert: "", titleSingleButton: "Close")
                return
            }
            
            guard let response = res as? HTTPURLResponse, (200...299).contains(response.statusCode)
            else {
//                print("Error with the response, unexpected status code: \(res)")
                vc.showErrorAlert(errorMsg: "Error with the response, unexpected status code: \(res)", isAction: false, title: "", typeAlert: "", titleSingleButton: "Close")
                return
            }
            
            if let data = resData,
               let result = try? JSONDecoder().decode(ResponseResult.self, from: data){
                
                for item in result.results{
                    let objPlay = PLAYLIST(imageName: item.artworkUrl100, songName: item.trackName, artistName: item.artistName, albumName: item.collectionName, previewURL: item.previewUrl, isPlay: false)
                    listSong.append(objPlay)
                }
                
                print("result list : \(listSong)")
                completion(listSong)
            }
        })
        
        task.resume()
        
    }
}
