//
//  Journal.swift
//  MC1-ADA
//
//  Created by Alejandro Oliva Ochoa on 19/10/23.
//

import SwiftUI

struct Journal: View{
    
    private var db = Database()
    
    @State var toDoList: [String]
    @State private var newToDo = ""
    @FocusState private var isTextFieldFocused: Bool
    
    
    init() {
        
        self.toDoList = db.load(key: "toDoList")
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.greenTheme)]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.greenTheme)]
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
            
            ZStack (alignment: .bottomTrailing){
                
                List{
                    ForEach($toDoList, id: \.self, editActions: .all){ $toDo in
                        
                        HStack(){
                            Text(toDo)
                                .padding(.vertical, 10)
                            Spacer()
                            Image(systemName: "line.horizontal.3")
                        }
                    }
                    .onDelete(perform: { indexSet in
                        toDoList.remove(atOffsets: indexSet)
                        db.save(array: toDoList, key: "toDoList")
                    })
                    .onMove(perform: { indexSet, destination in
                        // Move the elements in the toDoList array
                        toDoList.move(fromOffsets: indexSet, toOffset: destination)
                        // Save the new toDoList array
                        db.save(array: toDoList, key: "toDoList")
                    })
                    
                    TextField("Add new item", text: $newToDo)
                        .focused($isTextFieldFocused)
                        .onSubmit {
                            if(newToDo != ""){
                                toDoList.append(newToDo)
                                db.save(array: toDoList, key: "toDoList")
                                
                                newToDo = ""
                                isTextFieldFocused = false
                            }
                        }
                        .padding(.vertical, 10)
                }
                .listStyle(PlainListStyle())
                
                Button{
                    isTextFieldFocused = true
                } label: {
                    if(!isTextFieldFocused){
                        Image(systemName: "plus")
                            .padding()
                            .font(.title.weight(.semibold))
                            .background(Color.greenTheme)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
                .padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 35))
            }
            
            .navigationTitle("Journal")
            .onAppear(){
                toDoList = db.load(key: "toDoList")
            }
        }
    }
}



#Preview {
    Journal()
}

