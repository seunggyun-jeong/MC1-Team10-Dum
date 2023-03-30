//
//  File.swift
//  
//
//  Created by apple on 2023/03/30.
//

import AVFoundation

class AudioPlayer {
    
    var player: AVAudioPlayer?
    
    func audioPlay(name: String, numberOfLoops: Int=1) {
        let url = Bundle.main.url(forResource: name, withExtension: "mp3")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = numberOfLoops // -1로 설정하면 무한반복
            player?.play()
        } catch {
            print("\(name)")
            print("error loading file")
        }
    }
    
    func audioStop() {
        player?.stop()
    }

}
