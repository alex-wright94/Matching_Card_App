//
//  SoundManager.swift
//  MatchingCardapp
//
//  Created by Alex Wright on 5/20/20.
//  Copyright © 2020 Alex Wright. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    var audioPlayer:AVAudioPlayer?
    
    
    enum SoundEffect {
        case flip
        case match
        case nomatch
        case shuffle
    }
    
    func PlaySound(effect:SoundEffect) {
        var soundFilename = ""
        
        switch effect {
            case .flip:
                soundFilename = "cardflip"
                
            case .match:
                soundFilename = "dingcorrect"
                
            case .nomatch:
                soundFilename = "dingwrong"
                
            case .shuffle:
                soundFilename = "shuffle"
            
        
        
        
        }
//        get the path to the resource
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: ".wav")
        
//        check to see if its nil or not
        guard bundlePath != nil else {
//            couldnt find the resource, exit
            return
        }
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        do {
            
//            create the audio player
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            audioPlayer?.play()
            
        }
        catch {
            print("Couldn't create an audio player")
            return
        }
        
        
        
        
    }
    
}
