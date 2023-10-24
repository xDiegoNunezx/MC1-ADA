//
//  ContentViewOne.swift
//  MC1-ADA
//
//  Created by Eduardo Conti on 24/10/23.
//
import SwiftUI

struct ContentViewOne: View {
   @State var countDownTimer = 3
   @State var timerRunning = true
   let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
   @State var active = false
   
    var body: some View {
        
        NavigationView {
                    VStack {
                        NavigationStack {
                            Button{
                                timerRunning = true
                                countDownTimer = 3
                                print("pressed")
                            } label: {
                                Image("Inhale")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:330)
                            }
                            Image(systemName: "timer")
                            Text("\(countDownTimer)")
                                .onReceive(timer) { _ in
                                    if countDownTimer > 0 && timerRunning {
                                        countDownTimer -= 1
                                    } else {
                                        timerRunning = false
                                    }
                                }
                            Text("Hold to inhale")
                                .bold()
                                .font(.largeTitle)
                            Text("Release to exhale")
                                .bold()
                                .navigationBarTitle("Breath Exercises")
                            
                                .navigationBarItems(leading: HStack {
                                    Image(systemName: "chevron.backward")
                                    NavigationLink("Back", destination: Text("MainPage")
                                        .navigationBarBackButtonHidden(true))
                                    .foregroundColor(.black)
                                },
                                                    trailing: Image(systemName: "figure.mind.and.body"))
                        }
                    }
                    .padding()
        }
        .padding()
    }
}
            #Preview {
                    ContentViewOne()
                }
