//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7];
    
    var totalTime = 0;
    var secondsPassed = 0;
    var timer = Timer()
    var player: AVAudioPlayer!

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressBar.progress = 0.0
        secondsPassed = 0
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        titleLabel.text = hardness
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        let progresspercentage = Float(secondsPassed) / Float(totalTime);
        if secondsPassed < totalTime {
            print(secondsPassed, progresspercentage)
            secondsPassed += 1
            progressBar.progress = progresspercentage
            
        } else {
            timer.invalidate()
            progressBar.progress = 1.0
            titleLabel.text = "DONE"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
    
    
}

