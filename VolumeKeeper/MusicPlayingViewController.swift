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
    var thread: Thread!
    
    var volumeView: MPVolumeView!
    var isPlaying = true
    
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var repeatBtn: UIButton!
    @IBOutlet weak var changeSequenceBtn: UIButton!
    @IBOutlet weak var volumeFrame: UIView!
    @IBOutlet weak var playTimeSlider: UISlider!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    
    @IBAction func playPausePressed(_ sender: UIButton) {
        if isPlaying {
            musicPlayer.pause()
            playPauseBtn.setTitle("재생", for: .normal)
        } else {
            musicPlayer.play()
            playPauseBtn.setTitle("일시정지", for: .normal)
        }
        
        isPlaying = !isPlaying
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
    
    @IBAction func playTimeChanged(_ sender: UISlider) {
        musicPlayer.currentPlaybackTime = TimeInterval(playTimeSlider.value)
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
        
        volumeView = MPVolumeView(frame: volumeFrame.bounds)
        volumeFrame.addSubview(volumeView)
        
        playTimeSlider.maximumValue = Float((musicPlayer.nowPlayingItem?.playbackDuration)!)
        
        thread = Thread(target: self, selector: #selector(MusicPlayingViewController.loop), object: nil)
        thread.start()
        
        endTimeLabel.text = "\(Int(playTimeSlider.maximumValue) / 60) : \(Int(playTimeSlider.maximumValue) % 60)"
    }
    
    func loop() {
        while true {
            if isPlaying {
                DispatchQueue.main.async {
                    self.playTimeSlider.setValue(self.playTimeSlider.value + 1, animated: true)
                    self.startTimeLabel.text = "\(Int(self.playTimeSlider.value) / 60) : \(Int(self.playTimeSlider.value) % 60)"
                }
            }
            Thread.sleep(forTimeInterval: 1)
        }
    }
}

