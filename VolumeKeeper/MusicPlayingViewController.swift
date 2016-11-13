//
//  ViewController.swift
//  VolumeKeeper
//
//  Created by 이동규 on 2016. 11. 11..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import MediaPlayer

class MusicPlayingViewController: UIViewController {
    
    var viewModel = MusicPlayingViewModel()
   
    let musicPlayer = MPMusicPlayerController()
    
    @IBOutlet weak var playPauseBtn: UIButton!
    
    @IBAction func playPausePressed(_ sender: UIButton) {
        if musicPlayer.playbackState == .playing {
            musicPlayer.pause()
        } else {
            musicPlayer.play()
        }
    }
    
    @IBAction func nextSongPlayPressed(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
    }
    
    @IBAction func prevSongPlayPressed(_ sender: UIButton) {
        musicPlayer.skipToPreviousItem()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if musicPlayer.playbackState == .playing {
            musicPlayer.stop()
        }
        musicPlayer.setQueue(with: viewModel.musicList)
        musicPlayer.nowPlayingItem = viewModel.musicList.items[viewModel.index]
        musicPlayer.play()
    }
}

