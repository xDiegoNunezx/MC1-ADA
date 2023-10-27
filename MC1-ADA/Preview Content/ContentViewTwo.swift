//
//  ContentViewTwo.swift
//  MC1-ADA
//
//  Created by Eduardo Conti on 19/10/23.
//

import SwiftUI

struct ContentViewTwo: View {
    @State var countDownTimer = 3
    @State var timerRunning = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var show = false
    
    var body: some View {
        VStack {
            NavigationStack {
                Button {
                    timerRunning = true
                    countDownTimer = 3
                    print("pressed")
                } label: {
                    Image("Exhale")
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
                Text("Release to exhale")
                    .bold()
                    .font(.largeTitle)
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
  }

#Preview {
    ContentViewTwo()
}

