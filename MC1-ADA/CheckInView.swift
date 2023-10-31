//
//  CheckInView.swift
//  MC1-ADA
//
//  Created by Diego Ignacio Nunez Hernandez on 19/10/23.
//

import SwiftUI
import CoreHaptics

struct CheckInView: View {
    var db = Database()
    @State private var isPressed: [Int] = [0, 0, 0]
    @State private var sliderValue: Double = 1.0
    @State private var fullText: String = ""
    @State private var newNote: CheckInNote = CheckInNote(content: "", feeling: 1, date: Date(), quote: "")
    @Binding var isPresented: Bool
    
    let encoder = JSONEncoder()
    
    func getIntFeeling() -> Int {
        if isPressed[0] == 1 {
            return 3
        } else if isPressed[1] == 1 {
            return 2
        } else {
            return 1
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView() {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Set your mood level:")
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
                            if isPressed[0] == 1 {
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
                            if isPressed[1] == 1 {
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
                            if isPressed[2] == 1 {
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
                    .padding(.bottom, 20)
                    
                    Spacer()
                    
                    Text("Would you like to express your feelings?")
                        .font(.system(size: 25, weight: .bold))
                        .bold()
                        .padding(.leading)
                        .padding(.bottom, 10)
                    
                    //                    TextField("I'm feeling this way because...", text: $fullText, onCommit: {
                    //                        submitCheckIn()
                    //                    })
                    //                    .textFieldStyle(.roundedBorder)
                    //                    .padding()
                    //                    .lineLimit(5...)
                    //                    .font(.body)
                    
                    TextField("I'm feeling this way beacuse...",text: $fullText,axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .lineLimit(5...)
                        .font(.body)
                    //old version, not submitabble with return
                }
                
                Button {
                    submitCheckIn()
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
                .padding(.bottom, 30)
            }
            .scrollDismissesKeyboard(.automatic)
            .navigationTitle("New Check-in")
        }
    }
    
    func submitCheckIn() {
        if fullText != "" && (isPressed[0] != 0 || isPressed[1] != 0 || isPressed[2] != 0) {
            isPresented = false
            
            newNote.content = fullText
            newNote.date = Date()
            newNote.feeling = getIntFeeling()
            newNote.quote = getQuote(feeling: getIntFeeling())
            
            if let savedData = UserDefaults.standard.data(forKey: "notes") {
                let decoder = JSONDecoder()
                if var loadedNotes = try? decoder.decode([CheckInNote].self, from: savedData) {
                    loadedNotes.insert(newNote, at: 0)
                    
                    if let encodedData = try? encoder.encode(loadedNotes) {
                        UserDefaults.standard.set(encodedData, forKey: "notes")
                    }
                }
            } else {
                let newNotes = [newNote]
                print(newNotes)
                if let encodedData = try? encoder.encode(newNotes) {
                    UserDefaults.standard.set(encodedData, forKey: "notes")
                }
            }
        }
    }
}

var happy = [
    "You are a champion in life!",
    "Shine like the star you are!",
    "Keep up the good work!",
    "Smile, life is an exciting adventure!",
    "You are a ray of sunshine on a cloudy day!",
    "Happiness is contagious, share it with the world!",
    "Today is the gift, that's why it's called present.",
    "Celebrate life in every beat of your heart.",
    "Success is the sum of small daily victories.",
    "Joy is in the simple moments and in the love you give."
]

var neutral = [
    "Every day is a new blank page.",
    "Small steps, big achievements.",
    "Enjoy the simple moments.",
    "Progress matters, not speed.",
    "Life is a journey, celebrate every progress.",
    "Routine is the blank canvas of creativity.",
    "Every day is a blank page to write your story.",
    "Life is found in the everyday details.",
    "Progress comes in small steps.",
    "Enjoy the journey, not just the destination."
]

var sad = [
    "The storm will pass, the sun will shine again.",
    "You are stronger than you think.",
    "Every day is a new opportunity.",
    "Challenges are opportunities for growth.",
    "You are a beacon of hope.",
    "Tears are the prelude to a smile.",
    "Pain is temporary, strength is forever.",
    "Every fall is an opportunity to get up stronger.",
    "The clouds will clear and you will see the rainbow.",
    "You are someone's reason to smile, even on your darkest days."
]

func getQuote(feeling: Int) -> String {
    var quotes: [String]
    
    switch feeling {
    case 1:
        quotes = happy
    case 2:
        quotes = neutral
    case 3:
        quotes = sad
    default:
        return ""
    }
    
    // Obtener una frase aleatoria del arreglo correspondiente
    if let randomQuote = quotes.randomElement() {
        return randomQuote
    } else {
        return ""
    }
}
