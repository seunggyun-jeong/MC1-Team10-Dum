//
//  File.swift
//  
//
//  Created by apple on 2023/03/29.
//

import AVFoundation

class Recorder: NSObject, ObservableObject {
    private var audioRecorder: AVAudioRecorder!
    @Published var decibels: Double = 0.0
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func startRecording() {
        let session = AVAudioSession.sharedInstance()
        if session.recordPermission != .granted {
            session.requestRecordPermission { (isGranted) in
                if !isGranted {
                    fatalError("You must allow audio recording for this demo to work")
                }
            }
        }
        
        do {
            try session.setCategory(.playAndRecord, mode: .default, options: [])
            try session.setActive(true)
            let settings: [String:Any] = [
                AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: getDocumentsDirectory().appendingPathComponent("recording.m4a"), settings: settings)
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } catch {
            print("Error: \\(error.localizedDescription)")
        }
    }

    func stopRecording() {
        audioRecorder.isMeteringEnabled = false
        audioRecorder.stop()
    }
    
    func updateDecibels() -> Double {
        audioRecorder.updateMeters()
        let decibels = audioRecorder.peakPower(forChannel: 0)
        self.decibels = (Double(decibels) + 160) * 2
        return self.decibels
    }
}
