//
//  SoundsPractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 6/29/23.
//

import SwiftUI
import AVKit

class SoundManager: ObservableObject{
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String{
        case tada
        case badum
    }
    
    func playSound(sound: SoundOption){
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error{
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

struct SoundsPractice: View {
        
    var body: some View {
        VStack(spacing: 40){
            Button("Play sound1") {
                SoundManager.instance.playSound(sound: .tada)
            }
            
            Button("Play sound2") {
                SoundManager.instance.playSound(sound: .badum)
            }
        }
    }
}

struct SoundsPractice_Previews: PreviewProvider {
    static var previews: some View {
        SoundsPractice()
    }
}
