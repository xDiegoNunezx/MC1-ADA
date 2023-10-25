//
//  NotesView.swift
//  MC1-ADA
//
//  Created by Diego Ignacio Nunez Hernandez on 25/10/23.
//

import SwiftUI

struct NotesView: View {
    private var db = Database()
    @State var notes: [CheckInNote] = [CheckInNote(content: "Me siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento malMe siento mal", feeling: 3, date: Date()),
        CheckInNote(content: "Me siento bien", feeling: 1, date: Date())]
    //private var groupedNotes: [Date:[CheckInNote]]
    
    init() {
        
        //self.notes = db.load(key: "notes")
        //self.groupedNotes = groupNotes(notes)
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.greenTheme)]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.greenTheme)]
    }
    
    
    var body: some View {
        NavigationStack {
            List() {
                ForEach($notes) { $note in
                    HStack(alignment: .top) {
                        VStack(alignment: .leading){
                            Text(note.date.formatted())
                                .font(.caption)
                            Text(note.content)
                        }
                        .padding()
                        Spacer()
                        Image(getFeeling(feeling: note.feeling))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 60)
                            
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Check-In History")
            .onAppear(){
                //notes = db.load(key: "notes")
            }
        }
    }
}

func getFeeling(feeling: Int) -> String {
    switch feeling {
    case 1: return "Smile"
    case 2: return "Poker"
    case 3: return "Sad"
    default: return ""
    }
}

//func groupNotes(_ notes: [CheckInNote]) -> [Date:[CheckInNote]]{
//    
//}

#Preview {
    NotesView()
}
