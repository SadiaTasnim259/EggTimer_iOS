//
//  ViewController.swift
//  EggTimer
//
//  Created by Sadia on 24/6/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var timer = Timer()
    var totalTime = 10
    var remainingTime:Int = 0
    var player:AVAudioPlayer?

    let eggTime = ["Soft": 5 , "Medium": 7, "Hard": 10]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func eggButtonPressed(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        
        totalTime = eggTime[hardness] ?? 0  // ekane eggTime er key hardness er maddhome set kora ache akn totalTime print korlei key er respect e value print hoye jabe
        remainingTime = totalTime
        
        infoLabel.text = "\(hardness) boiling!"
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        progressBar.progress = 0.0
        
    }
    @objc func update(){
        remainingTime -= 1
        let progress = totalTime - remainingTime
        let progressValue = Float(progress)/Float(totalTime)
        progressBar.progress = progressValue
        
        if remainingTime < 0{
            timer.invalidate()
        }
        if remainingTime == 0{
            infoLabel.text = "Done!"
            progressBar.progress = 1.0
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player!.play()
        }
        
    }
}

