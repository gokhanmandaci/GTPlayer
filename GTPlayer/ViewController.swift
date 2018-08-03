//
//  ViewController.swift
//  GTPlayer
//
//  Created by Gökhan Mandacı on 3.08.2018.
//  Copyright © 2018 Gökhan Mandacı. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Parameters
    var counter = 0
    let videoThumbStrings = [
        "https://cdn.duuple.com/challenge/e049/thumb/00001/e0490655-fabf-4039-a9a5-1c02dbbdcc21.jpg",
        "hhttps://cdn.duuple.com/challenge/905a/thumb/00001/905a956d-6342-41d0-b526-487effab2380.jpg",
        "https://cdn.duuple.com/challenge/7287/thumb/00001/7287aab6-3198-4365-be54-5707cbaa1ade.jpg",
        "https://cdn.duuple.com/challenge/67ce/thumb/00001/67ceca9c-d469-43b0-83ae-f48bcfbd5b98.jpg",
        "https://cdn.duuple.com/challenge/771f/thumb/00001/771fb9d3-f77f-454b-aa8a-f54e81cb2661.jpg"
    ]
    let videoStrings = [
        "https://cdn.duuple.com/challenge/e049/480p/e0490655-fabf-4039-a9a5-1c02dbbdcc21.mp4",
        "https://cdn.duuple.com/challenge/905a/480p/905a956d-6342-41d0-b526-487effab2380.mp4",
        "https://cdn.duuple.com/challenge/7287/480p/7287aab6-3198-4365-be54-5707cbaa1ade.mp4",
        "https://cdn.duuple.com/challenge/67ce/480p/67ceca9c-d469-43b0-83ae-f48bcfbd5b98.mp4",
        "https://cdn.duuple.com/challenge/771f/480p/771fb9d3-f77f-454b-aa8a-f54e81cb2661.mp4"
    ]
    
    // MARK: Outlets
    @IBOutlet weak var gtView: GTView!
    
    // MARK: Actions
    @IBAction func btnNextVideoAction(_ sender: Any) {
        gtView.loadImage(with: videoThumbStrings[counter])
        gtView.playVideo(with: videoStrings[counter])
        if counter == 4 {
            counter = 0
        } else {
            counter += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        gtView.setImageContent()
    }

}

