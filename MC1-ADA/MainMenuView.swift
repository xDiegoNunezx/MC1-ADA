//
//  MainMenuView.swift
//  MC1-ADA
//
//  Created by Alejandro Oliva Ochoa on 20/10/23.
//

import SwiftUI

struct MainMenuView: View {
    
    var viewModel = MenuItemModel()
    @State var isShowingNotesView = false
    
    var body: some View {
        
        NavigationStack {
            VStack{
                ForEach(viewModel.mainMenu) { menuItem in
                    NavigationLink(destination: getView(for: menuItem.title)) {
                        ZStack {
                            HStack(alignment: .center) {
                                Text(menuItem.title)
                                    .font(.title)
                                    .bold()
                                    .foregroundStyle(Color.greenTheme)
                                Spacer()
                                Image(systemName: menuItem.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50)
                                    .foregroundStyle(Color.greenTheme)
                            }
                            .padding(EdgeInsets(top: 25, leading: 25, bottom: 25, trailing: 30))
                            .frame(height: 160)
                            .background(
                                LinearGradient(
                                    stops: [
                                        menuItem.stopsArray[0], menuItem.stopsArray[1]
                                    ],
                                    startPoint: UnitPoint(x: 1.15, y: -0.11),
                                    endPoint: UnitPoint(x: -0.15, y: 0.85)
                                )
                            )
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.3), radius: 1, x: 1, y: 2)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .padding(.top, 30)
            
            Spacer()
                .navigationTitle("Home")
        }
        .accentColor(.black)
    }
}

func getView(for title: String) -> some View {
    switch title {
    case "Meditation":
        return AnyView(Meditation())
    case "Relaxation":
        return AnyView(Relaxation())
    case "Journal":
        return AnyView(Journal())
    case "Check-ins":
        return AnyView(NotesView())
    default:
        return AnyView(Meditation())
    }
    
}


#Preview {
    MainMenuView()
}
