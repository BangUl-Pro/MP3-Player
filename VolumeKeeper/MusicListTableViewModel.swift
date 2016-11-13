//
//  MusicListViewModel.swift
//  VolumeKeeper
//
//  Created by 이동규 on 2016. 11. 12..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation
import MediaPlayer

class MusicListTableViewModel {
    var musicList: [MPMediaItem] = []
    
    func loadMusicList(completion: (([MPMediaItem]?) -> Void)?) {
        if #available(iOS 9.3, *) {
            let authorizationStatus = MPMediaLibrary.authorizationStatus()
            switch authorizationStatus {
            case .notDetermined:
                MPMediaLibrary.requestAuthorization({
                    newAuthorizationStatus in
                    if newAuthorizationStatus == .authorized {
                        if let list = MPMediaQuery.songs().items, let completion = completion {
                            self.musicList = list
                            completion(self.musicList)
                        }
                    }
                })
                
            case .restricted, .denied:
                return
                
            default:
                if let list = MPMediaQuery.songs().items, let completion = completion {
                    self.musicList = list
                    completion(self.musicList)
                }
            }
        }
    }
}
