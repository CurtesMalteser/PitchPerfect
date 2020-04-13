//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Antonio on 07.04.20.
//  Copyright © 2020 CurtesMalteser. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(false)
    }
    
    // MARK: Record audio

    @IBAction func recordAudio(_ sender: Any) {
        
        configureUI(true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    // MARK: Stop recording audio
    
    @IBAction func stopRecording(_ sender: Any) {
        
        configureUI(false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: AVAudioRecorderDelegate audioRecorderDidFinishRecording
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            self.performSegue(withIdentifier: "stopRecordingSegue", sender: audioRecorder.url)
        } else {
            print("Save recording didn't succeeded")
        }
    }
    
    // MARK: Prepare for Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "stopRecordingSegue") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            
            playSoundsVC.recordedAudioURL = recordedAudioURL
            
        }
    }
    
    // MARK: UI Functions

    func configureUI(_ isRecording: Bool) {
        if(isRecording) {
            recordingLabel.text = "Recording in Progress"
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
       } else {
           stopRecordingButton.isEnabled = false
           recordButton.isEnabled = true
           recordingLabel.text = "Tap to Record"
        }
    }

}

