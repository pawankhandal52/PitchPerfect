//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by StemDot on 7/3/17.
//  Copyright © 2017 Stemdot. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

    
    @IBOutlet var recordingLabel: UILabel!
    var audioRecorder:AVAudioRecorder!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will apear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("View did load")
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
    }

    


    @IBAction func stopRecording(_ sender: Any) {
        print("Recording stop")
        recordingLabel.text = "Tap to Record"
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
        audioRecorder.stop()
        let audioSession  = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    @IBAction func recordButton(_ sender: Any) {
        print("record button was pressed")
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        
        recordingLabel.text = "Recording in progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        //print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopRecordingButton: UIButton!
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag{
             performSegue(withIdentifier: "stopRecording", sender:audioRecorder.url)
        }else{
            print(" recording Failed")
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            
        let playSoundsVC = segue.destination as! PlaySoundsViewController
        let recordedAudioURL = sender as! URL
        playSoundsVC.recordedAudioURL = recordedAudioURL
            
        }
}

}
