//
//  MusicListViewController.swift
//  VolumeKeeper
//
//  Created by 이동규 on 2016. 11. 11..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import MediaPlayer
import MarqueeLabel

class MusicListViewController: UIViewController {

    @IBOutlet weak var musicListTableView: UITableView!
    
    let cellId:String = "MusicListCell"
    
    let viewModel = MusicListTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.loadMusicList { (musicList) in
            self.musicListTableView.reloadData()
        }
    }
}


extension MusicListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        musicListTableView.delegate = self
        musicListTableView.dataSource = self
        musicListTableView.rowHeight = 75
        
        musicListTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.musicList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? MusicLIstTableViewCell
        guard let musicListCell = cell else {
            return UITableViewCell()
        }
        let cellViewModel = MusicListCellViewModel(music: viewModel.musicList[indexPath.row])
        
        musicListCell.titleLabel.text = cellViewModel.music.title
        
        if let albumTitle = cellViewModel.music.albumTitle, !albumTitle.isEmpty {
            musicListCell.albumLabel.text = cellViewModel.music.albumTitle
        } else {
            musicListCell.albumLabel.text = "알수없음"
        }
        
        return musicListCell
    }
}
