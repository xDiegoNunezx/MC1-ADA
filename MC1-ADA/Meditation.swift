//
//  Meditation.swiftsquare.and.arrow.up
//  MC1-ADA
//
//  Created by Antea La Cava on 19/10/23.
//

import SwiftUI
import AVFoundation

class AudioPlayer {
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "ambient", withExtension: "mp3") else { return }
        print(url)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            print(url)
            
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
            print(url)
            
        }
    }
    
    func stopSound() {
        player?.stop()
        
    }
}

struct Meditation: View {
    var viewModel = MeditationFrasiManagerClass()
    var audioPlayer = AudioPlayer()
    
    @State private var currentQuote: String = ""
    
    var body: some View {
        return ZStack {
            
            AnimatedBackground().edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Text(currentQuote)
                    .fontWeight(.bold)
                    .font(.system(size: 35))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .frame(minWidth: 300, maxWidth: 320, maxHeight: .infinity)
                    .onTapGesture {
                        // Change the current quote to a random one when tapped
                        currentQuote = viewModel.frasi.randomElement()?.quote ?? ""
                    }
            }
            .onAppear {
                // Initialize the current quote
                currentQuote = viewModel.frasi.randomElement()?.quote ?? ""
                audioPlayer.playSound()
                Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
                    currentQuote = viewModel.frasi.randomElement()?.quote ?? ""
                }
            }
            .onDisappear {
                audioPlayer.stopSound()
            }
            .navigationTitle("Meditation")
            /*.toolbar {
             Button(action: {
             // for future actions
             }){
             Image(systemName: "figure.mind.and.body")
             .foregroundStyle(Color.greenTheme)
             .padding(.init(top: 90, leading: 0, bottom: 0, trailing: 0))
             .font(.system(size: 25))
             }
             }*/
        }
    }
    struct AnimatedBackground: View {
        @State private var gradientStart = UnitPoint(x: 6, y: 5)
        @State private var gradientEnd = UnitPoint(x: 5, y: 4)
        
        let colors = [Color.indigo ,Color.green, Color.brown, Color.mint, Color.teal]
        var body: some View {
            LinearGradient(gradient: Gradient(colors: colors), startPoint: gradientStart, endPoint: gradientEnd)
                .onAppear() {
                    withAnimation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                        self.gradientStart = UnitPoint(x: 1, y: 10)
                        self.gradientEnd = UnitPoint(x: 9, y: -20)
                    }
                }
        }
    }
}

#Preview {
    Meditation()
}
