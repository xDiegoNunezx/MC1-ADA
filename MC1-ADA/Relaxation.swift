//
//  Relaxation.swift
//  MC1-ADA
//
//  Created by Karan Oroumchi on 27/10/23.
//

import SwiftUI
import CoreHaptics

struct Relaxation: View {
    @State private var timer: Timer? = nil
    @State private var count = 5
    @State private var breath = "   "
    @State private var progress: CGFloat = 0
    @State private var engine: CHHapticEngine?
    @State private var isBreathing = false
    
    var body: some View {
        NavigationStack{
            VStack {
                
                Text("\(breath)")
                    .font(.title)
                    .padding(.bottom, 30)
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.3)
                        .foregroundColor(Color(hue: 0.443, saturation: 0.08, brightness: 0.775))
                        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.width * 0.7)
                    
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.greenTheme)
                        .rotationEffect(Angle(degrees: 270.0))
                        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.width * 0.7)
                    
                    VStack {
                        Image(systemName: "character.duployan")
                            .font(.system(size: 50))
                            .foregroundColor(.greenTheme)
                            .modifier(Glow(radius: 1))
                            .scaleEffect(isBreathing ? 1.3 : 0.8)
                            .animation(.smooth(duration: 6).repeatForever(autoreverses: true), value: isBreathing)
//                        Text("\(count)")
//                            .font(.largeTitle)
//                            .foregroundColor(.greenTheme)
//                            .padding()
                    }
                }
                
                
                Button(action: {
                    if isBreathing {
                        timer?.invalidate()
                        timer = nil
                        count = 5
                        withAnimation {
                            progress = 0
                        }
                        breath = "   "
                    } else {
                        breath = "Inhale"
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            if count > 0 {
                                count -= 1
                                withAnimation {
                                    progress += 0.2
                                }
                                do {
                                    let pattern = try CHHapticPattern(events: [CHHapticEvent(eventType: .hapticTransient, parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1), CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)], relativeTime: 0)], parameters: [])
                                    let player = try engine?.makePlayer(with: pattern)
                                    try player?.start(atTime: CHHapticTimeImmediate)
                                } catch {
                                    print("Failed to play pattern: \(error.localizedDescription)")
                                }
                            } else {
                                count = 5
                                withAnimation {
                                    progress = 0
                                }
                                breath = breath == "Inhale" ? "Exhale" : "Inhale"
                                do {
                                    let continuousPattern = try CHHapticPattern(events:
                                                                                    [CHHapticEvent(eventType: .hapticContinuous, parameters:
                                                                                                    [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1),
                                                                                                     CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)], relativeTime: 0, duration: 1)], parameters : [])
                                    let continuousPlayer = try engine?.makePlayer(with : continuousPattern)
                                    try continuousPlayer?.start(atTime : CHHapticTimeImmediate)
                                } catch {
                                    print("Failed to play pattern : \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                    isBreathing.toggle()
                }) {
                    Text(isBreathing ? "Pause Breathing" : "Start Breathing")
                        .bold()
                        .padding(20)
                        .background(Color.greenTheme)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(10)
                }
                .padding(.top, 30)
            }
            .onAppear {
                let hapticEngine = try? CHHapticEngine()
                self.engine = hapticEngine
                try? hapticEngine?.start()
            }
            .onDisappear {
                // Cleanup code when leaving the view
                timer?.invalidate()
                engine?.stop()
            }
            .navigationTitle("Relaxation")
        }
    }
}

struct Glow: ViewModifier {
    var radius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: .greenTheme, radius: radius)
    }
}


#Preview{
    Relaxation()
}
