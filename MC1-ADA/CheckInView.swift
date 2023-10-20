//
//  CheckInView.swift
//  MC1-ADA
//
//  Created by Diego Ignacio Nunez Hernandez on 19/10/23.
//

import SwiftUI

struct CheckInView: View {
    init() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.12, green: 0.45, blue: 0.41, alpha: 1.00)]

            //Use this if NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 0.12, green: 0.45, blue: 0.41, alpha: 1.00)]
    }
    
    @State private var isPressed: [Int] = [0,0,0]
    @State private var sliderValue: Double = 1.0
    @State private var labelText: String = "LIFE RULES!"
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Set your mood level:")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 50)
                HStack {
                    Button(action: {
                        isPressed[0] = 1
                        isPressed[1] = 0
                        isPressed[2] = 0
                    }, label: {
                    if(isPressed[0]==1){
                        Image("SadFilled")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    } else {
                        Image("Sad")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    })
                    Button(action: {
                        isPressed[0] = 0
                        isPressed[1] = 1
                        isPressed[2] = 0
                    }, label: {
                        if(isPressed[1]==1){
                            Image("PokerFilled")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Image("Poker")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    })
                    Button(action: {
                        isPressed[0] = 0
                        isPressed[1] = 0
                        isPressed[2] = 1
                    }, label: {
                        if(isPressed[2]==1){
                            Image("SmileFilled")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Image("Smile")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    })
                }
                .padding(.horizontal, 20)
                Spacer()
                Text("Set your stress level: ")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 50)
                Slider(value: $sliderValue, in: 1.0...3.0, step: 0.5)
                    .tint(.greenTheme)
                    .frame(width: 350)
                
                    .onChange(of: sliderValue, {
                        withAnimation {
                            updateLabelText(for: sliderValue)
                        }
                    })
                    //.background(
                    //    Capsule()
                    //        .foregroundColor(.greenTheme)
                    //)
                    .padding(.bottom, 50)
                    
                
                
                Text(labelText)
                    .transition(.slide)
                    .animation(.bouncy(duration: 1), value: 1)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.greenTheme)
                Spacer()
                    
            }
            .navigationTitle("Check-In")
        }
        
        
    }
    
    private func updateLabelText(for value: Double) {
        if value < 1.5 {
            labelText = "LIFE RULES!"
        } else if value < 2.0 {
            labelText = "I feel lucky"
        } else if value < 2.5 {
            labelText = "Meh"
        } else if value < 3.0{
            labelText = "I wanna punch walls"
        } else {
            labelText = "LifE s%ckS"
        }
    }
}



#Preview {
    CheckInView()
}
