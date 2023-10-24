//
//  MC1_ADAApp.swift
//  MC1-ADA
//
//  Created by Diego Ignacio Nunez Hernandez on 13/10/23.
//

import SwiftUI
import AVFoundation

@main
struct MC1_ADAApp: App {
    init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
        try? AVAudioSession.sharedInstance().setActive(true)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
            ContentViewTwo()
        }
    }
}
