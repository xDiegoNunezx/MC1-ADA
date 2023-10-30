//
//  OnboardingView.swift
//  MC1-ADA
//
//  Created by Eduardo Conti on 30/10/23.
//

import SwiftUI


struct OnboardingView: View {
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    private var previewIsFirstLaunch: Bool = true
    @State private var currentPage = 0
    
    var body: some View {
        if isFirstLaunch  {
            VStack{
                TabView (selection: $currentPage){
                    VStack {
                        Image("onboarding-image1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 400, alignment: .center)
                            .padding()
                        
                        Text("Welcome to iMind")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.greenTheme)
                            .padding()
                        
                        
                    }
                    .tag(0)
                    
                    VStack {
                        Image("onboarding-image2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300, alignment: .center)
                        
                        VStack {
                            Text("What is iMind?")
                                .font(.title)
                                .bold()
                                .foregroundColor(.greenTheme)
                                .padding()
                            
                            Text("iMind is an app focused on guiding individuals in achieving mindfulness and relaxation through simple instructions.")
                                .multilineTextAlignment(.center)
                                .font(Font.custom("SF Pro Rounded", size: 20))
                                .padding()
                        }
                    }
                    .tag(1)
                    
                    VStack {
                        Image("onboarding-image3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300, alignment: .center)
                            .padding()
                        
                        VStack {
                            Text("What is it for?")
                                .font(.title)
                                .bold()
                                .foregroundColor(.greenTheme)
                                .frame(width: 300, height: 50, alignment: .center)
                            
                            Text("Can serve as a vital tool to help individuals alleviate stress, calm their minds, and regain a sense of balance.")
                                .font(Font.custom("SF Pro Rounded", size: 20))
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }
                    .tag(2)
                    
                    VStack {
                        Image("onboarding-image4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300, alignment: .center)
                            .padding()
                        
                        VStack {
                            Text("Why wait then?")
                                .font(.title)
                                .bold()
                                .foregroundColor(.greenTheme)
                                .padding()
                            
                            Text("Let's get started! Start with meditation, try the breathing exercises and don't forget to check-in daily!")
                                .font(Font.custom("SF Pro Rounded", size: 20))
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }
                    .tag(3)
                    
                    
                }
                .tabViewStyle(PageTabViewStyle())
                
                .overlay(
                    Button(action: {
                        isFirstLaunch = false
                    }) {
                        Text("Skip")
                            .bold()
                            .padding(.horizontal, 30)
                            .padding(.vertical)
                            .background(Color.greenTheme)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    , alignment: Alignment.bottomTrailing
                )
                .overlay(
                    PageControl(numberOfPages: 4, currentPage: $currentPage)
                        .padding(.bottom, 90)
                    , alignment: Alignment.bottom
                )
            }
        } else {
            MainMenuView() // Your main view after onboarding
        }
    }
}



struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}


struct PageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfPages, id: \.self) { page in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(page == currentPage ? .greenTheme : .gray)
            }
        }
    }
}
