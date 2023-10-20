//
//  MainMenuView.swift
//  MC1-ADA
//
//  Created by Alejandro Oliva Ochoa on 20/10/23.
//

import SwiftUI

struct MainMenuView: View {
    
    var viewModel = MenuItemModel()
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.12, green: 0.45, blue: 0.41, alpha: 1.00)]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 0.12, green: 0.45, blue: 0.41, alpha: 1.00)]
    }
    
    var body: some View {
        NavigationStack{
            Spacer()
                .padding(.top, 20)
            
            ForEach(viewModel.mainMenu){ menuItem in
                ZStack{
                    HStack(alignment: .center){
                        Text(menuItem.title)
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(Color.greenTheme)
                        Spacer()
                        Text(menuItem.icon)
                    }
                    .padding(EdgeInsets(top: 20, leading: 25, bottom: 29, trailing: 25))
                    .frame(height: 160)
                    .background(
                        LinearGradient(
                            stops: [
                                menuItem.stopsArray[0], menuItem.stopsArray[1]
                            ],
                            startPoint: UnitPoint(x: 1.14, y: 0.21),
                            endPoint: UnitPoint(x: -0.15, y: 0.85)
                        )
                    )
                    .cornerRadius(15)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 15)
            
            Spacer()
            
            HStack{
                Spacer()
                Button{
                    // Do something
                } label: {
                    Image(systemName: "plus")
                        .padding()
                        .font(.title.weight(.semibold))
                        .background(Color.greenTheme)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding()
            }
            .navigationTitle("iMind")
        }
    }
}

#Preview {
    MainMenuView()
}
