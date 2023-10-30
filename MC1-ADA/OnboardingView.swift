//
//  OnboardingView.swift
//  MC1-ADA
//
//  Created by Eduardo Conti on 30/10/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        TabView {
            VStack {
                Image("onboarding-image")
                    .resizable()
                    .scaledToFit()
                    .frame(height:250)
                
                Text("Welcome to iMind")
                    .font(.title)
                    .bold()
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text("Page 1")
                    }
            }
            VStack {
                Image("onboarding-image2")
                    .resizable()
                    .scaledToFit()
                    .frame(height:250)
                Text("What is iMind?")
                    .font(.title)
                    .bold()
                Text("iMind is an app focused on guiding individuals in achieving mindfulness and relaxation through simple instructions.")
                    .multilineTextAlignment(.center)
                    .font(Font.custom("SF Pro", size: 20))
                    .tabItem {
                    }
                    .padding()
            }
            VStack {
                Image("onboarding-image3")
                    .resizable()
                    .scaledToFit()
                    .frame(height:250)
                Text("What is it for?")
                    .font(.title)
                    .bold()
                Text("Can serve as a vital tool to help individuals alleviate stress, calm their minds, and regain a sense of balance.")
                    .font(Font.custom("SF Pro", size: 20))
                    .multilineTextAlignment(.center)
                    .tabItem {
                    }
                    .padding()
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}
#Preview {
    OnboardingView()
}
