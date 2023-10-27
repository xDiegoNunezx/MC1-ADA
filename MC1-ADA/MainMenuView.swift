//
//  MainMenuView.swift
//  MC1-ADA
//
//  Created by Alejandro Oliva Ochoa on 20/10/23.
//

import SwiftUI

struct MainMenuView: View {
    
    var viewModel = MenuItemModel()
    @State var showSheetPresented = false
    @State var isShowingNotesView = false

    var body: some View {
        NavigationStack {
            Spacer()
                .padding(.top, 4)
            
            ForEach(viewModel.mainMenu){ menuItem in
                NavigationLink(destination: getView(for: menuItem.title)){
                    ZStack{
                        HStack(alignment: .center){
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
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 29, trailing: 25))
                        .frame(height: 120)
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
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 15)
            
            Spacer()
                .padding(.bottom, 10)
            
            HStack{
                Spacer()
                Button{
                    // Open the check in page
                    showSheetPresented.toggle()
                    
                } label: {
                    Text("Check in")
                        .font(.system(size: 25))
                        .foregroundStyle(.greenTheme)
                        .bold()
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 45))
                        .foregroundColor(.greenTheme)
                }
                .padding()
                .sheet(isPresented: $showSheetPresented, content: {
                    CheckInView(isPresented: $showSheetPresented)
                    
                })
            }
            .navigationTitle("iMind")
            
        }
        .accentColor(Color.greenTheme)                    
    }
}

func getView(for title: String) -> some View {
    switch title {
    case "Meditation":
        return AnyView(Meditation())
    case "Relaxation":
        return AnyView(ContentViewOne())
    case "Sort It Out":
        return AnyView(Sortitout())
    case "Check-in History":
        return AnyView(NotesView())
    default:
        return AnyView(Sortitout())
    }
}


#Preview {
    MainMenuView()
}
