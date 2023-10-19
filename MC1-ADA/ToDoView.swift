//
//  ToDoView.swift
//  MC1-ADA
//
//  Created by Alejandro Oliva Ochoa on 19/10/23.
//

import SwiftUI

struct ToDoView: View {
    
    @State var toDoList: [String] = [
        "Test element"
    ]
    @State private var newToDo = ""
    @FocusState private var isTextFieldFocused: Bool
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.12, green: 0.45, blue: 0.41, alpha: 1.00)]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 0.12, green: 0.45, blue: 0.41, alpha: 1.00)]
    }
    
    var body: some View {
        NavigationStack{
            
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
            
            
//
            
            ZStack (alignment: .bottomLeading){
                
                List{
                    ForEach($toDoList, id: \.self, editActions: .all){ $toDo in
                        HStack(){
                            Text(toDo)
                                .padding(.vertical, 10)
                            Spacer()
                            Image(systemName: "line.horizontal.3")
                        }
                    }
                    
                    TextField("New ToDo", text: $newToDo)
                        .focused($isTextFieldFocused)
                        .onSubmit {
                            if(newToDo != ""){
                                toDoList.append(newToDo)
                                newToDo = ""
                                isTextFieldFocused = false
                            }
                        }
                        .padding(.vertical, 10)
                }
                .listStyle(PlainListStyle())
                
                Button{
                    isTextFieldFocused = true
                    print("pressed")
                } label: {
                    if(!isTextFieldFocused){
                        Image(systemName: "plus")
                            .padding()
                            .font(.title.weight(.semibold))
                            .background(Color.greenTheme)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
                .padding(EdgeInsets(top: 1, leading: 35, bottom: 1, trailing: 1))
            }
            
            .navigationTitle("Sort It Out")
            .toolbar {
                Text("'Image'")
            }
        }
    }
}

#Preview {
    ToDoView()
}

