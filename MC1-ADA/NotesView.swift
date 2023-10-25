//
//  NotesView.swift
//  MC1-ADA
//
//  Created by Diego Ignacio Nunez Hernandez on 25/10/23.
//

import SwiftUI

struct NotesView: View {
    private var db = Database()
    @State var notes: [CheckInNote] = [
        CheckInNote(content: "Me siento mal", feeling: 3, date: Date()),
        CheckInNote(content: "Me siento bien", feeling: 1, date: Date())
    ]
    //private var groupedNotes: [Date:[CheckInNote]]
    
    let encoder = JSONEncoder()
    
    init() {
        if let savedData = UserDefaults.standard.data(forKey: "notes") {
            let decoder = JSONDecoder()
            if let loadedNotes = try? decoder.decode([CheckInNote].self, from: savedData) {
                // Asigna los datos recuperados a la variable `notes`
                notes = loadedNotes
            }
        }
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
                .onDelete(perform: { indexSet in
                    notes.remove(atOffsets: indexSet)
                    // Save the all the notes
                    if let encodedData = try? encoder.encode(notes) {
                        // Guarda el arreglo serializado en UserDefaults
                        UserDefaults.standard.set(encodedData, forKey: "notes")
                    }
                })
            }
            
            .listStyle(.plain)
            .navigationTitle("Check-In History")
            .onAppear(){
                if let savedData = UserDefaults.standard.data(forKey: "notes") {
                    let decoder = JSONDecoder()
                    if let loadedNotes = try? decoder.decode([CheckInNote].self, from: savedData) {
                        // Asigna los datos recuperados a la variable `notes`
                        notes = loadedNotes
                    }
                }
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
