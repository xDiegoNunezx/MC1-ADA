//
//  CheckInView.swift
//  MC1-ADA
//
//  Created by Diego Ignacio Nunez Hernandez on 19/10/23.
//

import SwiftUI

struct CheckInView: View {
    var db = Database()
    @State private var isPressed: [Int] = [0,0,0]
    @State private var sliderValue: Double = 1.0
    @State private var labelText: String = "LIFE RULES!"
    @State private var fullText: String = ""
    @State private var newNote: CheckInNote = CheckInNote(content: "", feeling: 1, date: Date())
    @State var notes: [CheckInNote] = [CheckInNote(content: "", feeling: 1, date: Date())]
    @Binding var isPresented: Bool
    
    func getIntFeeling() -> Int{
        if(isPressed[0]==1){
            return 3
        } else if (isPressed[1]==1) {
            return 2
        } else {
            return 1
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(){
                VStack(alignment: .leading) {
                    Text("Check-In")
                        .font(.largeTitle)
                        .foregroundStyle(.greenTheme)
                        .bold()
                        .padding()
                        .padding(.top, 30)
                    Spacer()
                    Text("Set your mood level:")
                    //.font(.title2)
                        .font(.system(size: 25, weight: .bold))
                        .bold()
                        .padding(.leading)
                        .padding(.bottom, 10)
                    
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
                    .padding(.horizontal)
                    .padding(.bottom,20)
                    
                    Spacer()
                    
                    Text("Would you like to express your feelings?")
                        .font(.system(size: 25, weight: .bold))
                    //.font(.title2)
                        .bold()
                        .padding(.leading)
                        .padding(.bottom, 10)
                    
                    TextField("I'm feeling this way beacuse...",text: $fullText,axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .lineLimit(5...)
                        .font(.body)
                }
                Button {
                    isPresented = false
                    
//                    // Create the new note
//                    newNote.content = fullText
//                    newNote.date = Date()
//                    newNote.feeling = getIntFeeling()
//                    
//                    // Update the local notes variable
//                    notes = db.load(key: "notes")
//                    
//                    // Append the new note
//                    notes.append(newNote)
//                    
//                    // Save the all the notes
//                    db.save(array: notes, key: "notes")
                } label: {
                    Text("Check-in")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.horizontal, 130)
                        .padding(.vertical, 18)
                        .cornerRadius(30)
                }
                .background(.greenTheme)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.bottom,30)
            }
        }
    }
}
