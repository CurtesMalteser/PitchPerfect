//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Antonio on 07.04.20.
//  Copyright © 2020 CurtesMalteser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording in Progress"
    }
    
    @IBAction func stopRecording(_ sender: Any) {
    }
    
}

