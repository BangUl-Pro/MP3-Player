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
    
    @IBOutlet weak var playPauseBtn: UIButton!
    
    @IBAction func playPausePressed(_ sender: UIButton) {
    }
    
    @IBAction func nextSongPlayPressed(_ sender: UIButton) {
    }
    
    @IBAction func prevSongPlayPressed(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let musicPlayer = MPMusicPlayerController()
        let a = MPMediaItemCollection(items: [viewModel.music])
        musicPlayer.setQueue(with: a)
        musicPlayer.play()
    }
}

