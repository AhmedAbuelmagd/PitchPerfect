//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Ahmed Abuelmagd on 2/18/18.
//  Copyright © 2018 Ahmed Abuelmagd. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController,AVAudioRecorderDelegate{

     var audioRecorder: AVAudioRecorder!
    
    //Connections
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }


    @IBAction func recordAudio(_ sender: UIButton) {
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
        recordingLabel.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    @IBAction func stopRecording(_ sender: UIButton) {
        recordingLabel.text = "Tab to record"
        stopRecordingButton.isEnabled = false
        recordingLabel.isEnabled = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
          performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("recording was not successful")
        }
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsCV = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsCV.recordedAudioURL = recordedAudioURL
        }
    }
}







