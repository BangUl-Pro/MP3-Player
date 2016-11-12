//
//  MusicListViewController.swift
//  VolumeKeeper
//
//  Created by 이동규 on 2016. 11. 11..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import MediaPlayer

class MusicListViewController: UIViewController {

    @IBOutlet weak var musicListTableView: UITableView!
    
    let viewModel = MusicListTableViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadMusicList(completion: nil)
    }
}


extension MusicListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func initTableView() {
        musicListTableView.delegate = self
        musicListTableView.dataSource = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
