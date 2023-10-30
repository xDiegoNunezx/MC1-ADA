//
//  NotesView.swift
//  MC1-ADA
//
//  Created by Diego Ignacio Nunez Hernandez on 25/10/23.
//

import SwiftUI
import CoreHaptics

struct NotesView: View {
    private var db = Database()
    @State var notes: [CheckInNote] = []
    @State private var groupedNotes: [String: [CheckInNote]] = [:]
    @State var showSheetPresented = false
    @State private var engine: CHHapticEngine?
    @State private var isShowingDeleteAlert = false
    @State private var deletionIndexSet: IndexSet?
    @State private var selection: Set<CheckInNote> = []
    
    let dateFormatter = DateFormatter()
    let encoder = JSONEncoder()
    
    init() {
        dateFormatter.dateFormat = "HH:mm"
        
        if let savedData = UserDefaults.standard.data(forKey: "notes") {
            let decoder = JSONDecoder()
            if let loadedNotes = try? decoder.decode([CheckInNote].self, from: savedData) {
                notes = loadedNotes
                groupedNotes = groupNotes(notes)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomLeading){
                if groupedNotes.isEmpty {
                    List{
                        HStack{
                            Spacer()
                            Text("Start adding how you feel by tapping the + button!")
                                .font(.title2)
                                .foregroundStyle(.gray.opacity(0.7))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .padding(.top, 250)
                        .listRowSeparator(.hidden)
                    }
                    
                    .listStyle(.plain)
                    .padding(.horizontal)
                    
                } else {
                    List {
                        ForEach(Array(groupedNotes), id: \.key) { date, values in
                            Text(date)
                                .bold()
                                .font(.title2)
                                .padding(.top, 20)
                            
                            ForEach(values) { value in
                                SingleNoteView(chekInNote: value, isExpanded: self.selection.contains(value))
                                    .onTapGesture { self.selectDeselect(value) }
                                    .animation(.smooth, value: 80.0)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            isShowingDeleteAlert = true
                            deletionIndexSet = indexSet
                        })
                        .alert(isPresented: $isShowingDeleteAlert) {
                            Alert(
                                title: Text("Delete Item"),
                                message: Text("Are you sure you want to delete this item?"),
                                primaryButton: .default(Text("Cancel")) {
                                    isShowingDeleteAlert = false // Dismiss the alert
                                },
                                secondaryButton: .destructive(Text("Delete")) {
                                    if let indexSet = deletionIndexSet {
                                        deleteItems(at: indexSet)
                                    }
                                    isShowingDeleteAlert = false // Dismiss the alert
                                }
                            )
                        }
                    }
                    .listStyle(.plain)
                    
                }
                HStack{
                    Button(action: {
                        showSheetPresented.toggle()
                        do {
                            let pattern = try CHHapticPattern(events: [CHHapticEvent(eventType: .hapticTransient, parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1), CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)], relativeTime: 0)], parameters: [])
                            let player = try engine?.makePlayer(with: pattern)
                            try player?.start(atTime: CHHapticTimeImmediate)
                        } catch {
                            print("Failed to play haptic pattern: \(error.localizedDescription)")
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 22, height: 22)
                                .foregroundStyle(.greenTheme)
                            Text("Check-in")
                                .foregroundStyle(.greenTheme)
                                .font(.system(size: 18))
                        }
                    })
                    .sheet(isPresented: $showSheetPresented, content: {
                        CheckInView(isPresented: $showSheetPresented)
                            .presentationDetents([.fraction(0.9), .large])
                            .presentationDragIndicator(.visible)
                            .onDisappear {
                                if let savedData = UserDefaults.standard.data(forKey: "notes") {
                                    let decoder = JSONDecoder()
                                    if let loadedNotes = try? decoder.decode([CheckInNote].self, from: savedData) {
                                        notes = loadedNotes
                                        groupedNotes = groupNotes(notes)
                                    }
                                    
                                }
                                
                            }
                    })
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .background(.white)
                
            }
        }
        .onAppear() {
            loadNotesFromUserDefaults() // Load data from UserDefaults when the view appears
            let hapticEngine = try? CHHapticEngine()
            self.engine = hapticEngine
            try? hapticEngine?.start()
        }
        .navigationTitle("Check-Ins")
    }
    func loadNotesFromUserDefaults() {
        if let savedData = UserDefaults.standard.data(forKey: "notes") {
            let decoder = JSONDecoder()
            if let loadedNotes = try? decoder.decode([CheckInNote].self, from: savedData) {
                notes = loadedNotes
                groupedNotes = groupNotes(notes)
            }
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
        
        let sortedGroupedNotes = groupedNotes.sorted { (entry1, entry2) in
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            if let date1 = dateFormatter.date(from: entry1.key), let date2 = dateFormatter.date(from: entry2.key) {
                return date1 > date2
            }
            return false
        }
        
        var sortedGroupedDictionary: [String: [CheckInNote]] = [:]
        for (date, notes) in sortedGroupedNotes {
            sortedGroupedDictionary[date] = notes
        }
        
        return sortedGroupedDictionary
    }
    
    func deleteItems(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        groupedNotes = groupNotes(notes)
        saveNotesToUserDefaults()
    }
    
    func saveNotesToUserDefaults() {
        if let encodedData = try? encoder.encode(notes) {
            UserDefaults.standard.set(encodedData, forKey: "notes")
        }
    }
    
    private func selectDeselect(_ note: CheckInNote) {
        if selection.contains(note) {
            selection.remove(note)
        } else {
            selection.insert(note)
        }
    }
    
}


#Preview {
    NotesView()
}
