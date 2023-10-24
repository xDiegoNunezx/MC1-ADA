//
//  ContentViewOne.swift
//  MC1-ADA
//
//  Created by Eduardo Conti on 24/10/23.
//
import SwiftUI

struct ContentViewOne: View {
    
    @State var countDownTimer = 5
    @State var timerRunning = true
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var active = false
    @State var inhaleActive = true
    @State var timeLabel = "Press to inhale"
    
    func starTimer(){
        timer = Timer.publish(every: 1, on: .main, in: .common)
        _ = timer.connect()
    }
    
    func stopTimer(){
        timer.connect().cancel()
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Button{
                    starTimer()
                } label: {
                    Image("Exhale")
                        .resizable()
                        .scaledToFit()
                        .frame(width:330)
                }
                Image(systemName: "timer")
                
                Text("\(countDownTimer)")
                    .onReceive(timer) { _ in
                        if countDownTimer > 0 {
                            countDownTimer -= 1
                        } else {
                            
                            if(inhaleActive){
                                timeLabel = "Exhale"
                            } else {
                                timeLabel = "Inhale"
                            }
                            inhaleActive = !inhaleActive
                                                                        
                            stopTimer()
                            countDownTimer = 5
                            starTimer()
                        }
                    }
                Text(timeLabel)
                    .bold()
                    .font(.largeTitle)
                    .navigationTitle("Breath Exercises")
            }
        }
        .padding()
    }
}
#Preview {
    ContentViewOne()
}
