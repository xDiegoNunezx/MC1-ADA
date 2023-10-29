//
//  NotesView.swift
//  MC1-ADA
//
//  Created by Diego Ignacio Nunez Hernandez on 25/10/23.
//

import SwiftUI

struct NotesView: View {
    private var db = Database()
    @State var notes: [CheckInNote] = []
    @State private var groupedNotes: [String:[CheckInNote]] = [:]
    @State var showSheetPresented = false
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
        
    }
    
    var body: some View {
        NavigationStack {
            
            if(groupedNotes.isEmpty){
                Text("Start adding how you feel by tapping the 'Add New' button")
                    .font(.title2)
                    .foregroundStyle(.gray.opacity(0.7))
                    .padding()
                    .multilineTextAlignment(.center)
            }
            
            List {
                ForEach(Array(groupedNotes), id: \.key) { date, values in
                    Text(date)
                        .bold()
                        .font(.title2)
                        .padding(.top, 20)
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
                                .padding(.top, 10)
                        }
                    }
                    
                }
            }
            .listStyle(.plain)
            .navigationTitle("Check-In History")
            .toolbar(){
                Button(action: {
                    showSheetPresented.toggle()
                }, label: {
                    HStack{
                        //                        Image(systemName: "plus")
                        //                            .foregroundStyle(.greenTheme)
                        Text("Add new")
                            .foregroundStyle(.black)
                    }
                })
                .sheet(isPresented: $showSheetPresented, content: {
                    CheckInView(isPresented: $showSheetPresented)
                        .presentationDetents([.fraction(0.8), .large])
                        .presentationDragIndicator(.visible)
                        .onDisappear {
                            if let savedData = UserDefaults.standard.data(forKey: "notes") {
                                let decoder = JSONDecoder()
                                if let loadedNotes = try? decoder.decode([CheckInNote].self, from: savedData) {
                                    // Assign the retrieved data to the notes variable
                                    notes = loadedNotes
                                    groupedNotes = groupNotes(notes)
                                }
                            }
                        }
                })
            }
            .onAppear(){
                if let savedData = UserDefaults.standard.data(forKey: "notes") {
                    let decoder = JSONDecoder()
                    if let loadedNotes = try? decoder.decode([CheckInNote].self, from: savedData) {
                        // Assign the retrieved data to the notes variable
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
    case 1: return "SmileFilled"
    case 2: return "PokerFilled"
    case 3: return "SadFilled"
    default: return ""
    }
}

func groupNotes(_ notes: [CheckInNote]) -> [String: [CheckInNote]] {
    var groupedNotes: [String: [CheckInNote]] = [:]
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM dd, yyyy"
    
    for note in notes {
        let date = dateFormatter.string(from: note.date)
        if groupedNotes[date] == nil {
            groupedNotes[date] = [note]
        } else {
            groupedNotes[date]?.append(note)
        }
    }
    
    // Sort the dictionary based on dates (newest first)
    let sortedGroupedNotes = groupedNotes.sorted { (entry1, entry2) in
        // Compare dates and sort in descending order
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let date1 = dateFormatter.date(from: entry1.key), let date2 = dateFormatter.date(from: entry2.key) {
            return date1 > date2
        }
        return false
    }
    
    // Create a new sorted dictionary
    var sortedGroupedDictionary: [String: [CheckInNote]] = [:]
    for (date, notes) in sortedGroupedNotes {
        sortedGroupedDictionary[date] = notes
    }
    
    return sortedGroupedDictionary
}

#Preview {
    NotesView()
}
