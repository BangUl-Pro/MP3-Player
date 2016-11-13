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
    let session = AVAudioSession.init()
    let volumeView = MPVolumeView()
    
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var repeatBtn: UIButton!
    @IBOutlet weak var changeSequenceBtn: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
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
    
    @IBAction func changeRepeatModePressed(_ sender: UIButton) {
        if musicPlayer.repeatMode == .all {
            musicPlayer.repeatMode = .one
            repeatBtn.setTitle("한 곡 반복", for: .normal)
        } else if musicPlayer.repeatMode == .one {
            musicPlayer.repeatMode = .none
            repeatBtn.setTitle("반복 X", for: .normal)
        } else {
            musicPlayer.repeatMode = .all
            repeatBtn.setTitle("전 곡 반복", for: .normal)
        }
    }
    
    @IBAction func changeSequenceModePressed(_ sender: UIButton) {
        if musicPlayer.shuffleMode == .off {
            musicPlayer.shuffleMode = .songs
            changeSequenceBtn.setTitle("랜덤", for: .normal)
        } else {
            musicPlayer.shuffleMode = .off
            changeSequenceBtn.setTitle("순차", for: .normal)
        }
    }
    
    @IBAction func volumeChanged(_ sender: Any) {
        if let view = volumeView.subviews.first as? UISlider {
            view.setValue(volumeSlider.value, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if musicPlayer.playbackState == .playing && musicPlayer.nowPlayingItem != viewModel.musicList.items[viewModel.index] {
            musicPlayer.stop()
        }
        musicPlayer.setQueue(with: viewModel.musicList)
        musicPlayer.nowPlayingItem = viewModel.musicList.items[viewModel.index]
        musicPlayer.play()
        
        if musicPlayer.shuffleMode == .off {
            changeSequenceBtn.setTitle("순차", for: .normal)
        } else {
            changeSequenceBtn.setTitle("랜덤", for: .normal)
        }
        
        if musicPlayer.repeatMode == .all {
            repeatBtn.setTitle("전 곡 반복", for: .normal)
        } else if musicPlayer.repeatMode == .one {
            repeatBtn.setTitle("한 곡 반복", for: .normal)
        } else {
            repeatBtn.setTitle("반복 X", for: .normal)
        }
        
        volumeSlider.setValue(session.outputVolume, animated: false)
    }
}

