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
        CheckInNote(content: "Im bad", feeling: 3, date: Date()),
        CheckInNote(content: "Im good", feeling: 1, date: Date())
    ]
    @State private var groupedNotes: [String:[CheckInNote]] = [:]
    let dateFormatter = DateFormatter()
    let encoder = JSONEncoder()
    
    
    init() {
        
        dateFormatter.dateFormat = "HH:mm"
        
        if let savedData = UserDefaults.standard.data(forKey: "notes") {
            let decoder = JSONDecoder()
            if let loadedNotes = try? decoder.decode([CheckInNote].self, from: savedData) {
                // Asigna los datos recuperados a la variable `notes`
                notes = loadedNotes
                groupedNotes = groupNotes(notes)
            }
        }
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.greenTheme)]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.greenTheme)]
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(groupedNotes), id: \.key) { key, values in
                    Text(key)
                        .bold()
                        .font(.title2)
                        .padding()
                    ForEach(values) { value in
                        HStack(alignment: .top) {
                            VStack(alignment: .leading){
                                Text(dateFormatter.string(from: value.date))
                                Text(value.content)
                            }
                            .padding()
                            Spacer()
                            Image(getFeeling(feeling: value.feeling))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 60)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Check-In History")
            .onAppear(){
                if let savedData = UserDefaults.standard.data(forKey: "notes") {
                    let decoder = JSONDecoder()
                    if let loadedNotes = try? decoder.decode([CheckInNote].self, from: savedData) {
                        // Asigna los datos recuperados a la variable `notes`
                        notes = loadedNotes
                        groupedNotes = groupNotes(notes)
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

func groupNotes(_ notes: [CheckInNote]) -> [String:[CheckInNote]]{
    var groupedNotes: [String:[CheckInNote]] = [:]
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    for note in notes {
        let date = dateFormatter.string(from: note.date)
        if groupedNotes[date] == nil {
            groupedNotes[date] = [note]
        } else {
            groupedNotes[date]?.append(note)
        }
    }
    
    return groupedNotes
}

#Preview {
    NotesView()
}
