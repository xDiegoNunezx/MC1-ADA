//
//  ToDoView.swift
//  MC1-ADA
//
//  Created by Alejandro Oliva Ochoa on 19/10/23.
//

import SwiftUI

struct ToDoView: View {
    
    var toDoList: [String] = [
        "Hola"
    ]
    
    var body: some View {
        NavigationStack {
            
            ZStack{
                Color(red: 0.94, green: 0.94, blue: 0.94)
                    .frame(height: 150)
                    .cornerRadius(15)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
                    
                
                Text("Write your assignments in the order of importance you think they have")
                    .font(.system(size: 25, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.greenTheme)
                    .bold()
                    .padding(.horizontal, 15.5)
            }
            .padding()
            .navigationTitle("Sort It Out")
            
        }
    }
}

#Preview {
    ToDoView()
}

