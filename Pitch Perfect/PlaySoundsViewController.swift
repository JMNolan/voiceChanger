//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by John Nolan on 11/29/17.
//  Copyright © 2017 John Nolan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    //enable or disable the stop button based on whether audio is currently playing or not
    func configurePlaybackUI (currentlyPlaying: Bool){
        switch currentlyPlaying {
        case true:
            stopButton.isEnabled = true
        default:
            stopButton.isEnabled = false
        }
    }
    
    //enum used to determine what effect should be applied on playback
    enum activeButton: Int {case slow = 0, fast, highPitch, lowPitch, echo, reverb}
    
    //augment the sound according to what button was pressed then play recording
    @IBAction func playSoundForButton(_sender: UIButton){
        switch (activeButton(rawValue: _sender.tag)!) {
        case .slow:
            playSound(rate:0.25)
        case .fast:
            playSound(rate:3)
        case .highPitch:
            playSound(pitch: 500)
        case .lowPitch:
            playSound(pitch: -500)
        case .echo:
            playSound(echo: true)
        default:
            playSound(reverb: true)
        }
        configurePlaybackUI(currentlyPlaying: true)
        
 
    }
    
    //stop the playing audio with the stop button
    @IBAction func stopButtonPressed(_ sender: AnyObject){
        stopAudio()
        configurePlaybackUI(currentlyPlaying: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slowButton.imageView?.contentMode = .scaleAspectFit
        fastButton.imageView?.contentMode = .scaleAspectFit
        highPitchButton.imageView?.contentMode = .scaleAspectFit
        lowPitchButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit
        setupAudio()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    

}
