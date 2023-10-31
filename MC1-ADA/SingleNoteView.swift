//
//  SingleNoteView.swift
//  MC1-ADA
//
//  Created by Diego Ignacio Nunez Hernandez on 30/10/23.
//

import SwiftUI

struct SingleNoteView: View {
    let chekInNote: CheckInNote
    let dateFormatter = DateFormatter()
    let isExpanded: Bool
    
    init(chekInNote: CheckInNote, isExpanded: Bool) {
        self.chekInNote = chekInNote
        self.isExpanded = isExpanded
        dateFormatter.dateFormat = "HH:mm"
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(dateFormatter.string(from: chekInNote.date))
                    .font(.caption)
                if isExpanded {
                    Text(chekInNote.content)
                        .padding(.bottom, 5)
                } else {
                    Text(chekInNote.content).lineLimit(1)
                        .padding(.bottom, 5)
                }
                    
                
                HStack{
                    Image(getFeeling(feeling: chekInNote.feeling))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                        .padding(.top, 3)
                    
                    Text(chekInNote.quote)
                        .font(.caption)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    
                    Spacer()
                }
                
            }
            .padding()
            
        }
        .contentShape(Rectangle())
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

#Preview {
    SingleNoteView(chekInNote: CheckInNote(content: "Me siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atm", feeling: 1, date: Date(), quote: ""), isExpanded: false)
}
