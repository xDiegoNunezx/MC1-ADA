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
                if isExpanded {
                    Text(chekInNote.content)
                } else {
                    Text(chekInNote.content).lineLimit(1)
                }
            }
            .padding()
            Spacer()
            Image(getFeeling(feeling: chekInNote.feeling))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 70)
                .padding(.top, 3)
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
    SingleNoteView(chekInNote: CheckInNote(content: "Me siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atmMe siento atm", feeling: 2, date: Date()), isExpanded: false)
}
