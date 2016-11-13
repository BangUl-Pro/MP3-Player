//
//  MusicListCellViewModel.swift
//  VolumeKeeper
//
//  Created by 이동규 on 2016. 11. 13..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation
import MediaPlayer

class MusicListCellViewModel {
    
    var music: MPMediaItem!
    
    init(music: MPMediaItem) {
        self.music = music
    }
}
