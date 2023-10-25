//
//  CheckInNote.swift
//  MC1-ADA
//
//  Created by Diego Ignacio Nunez Hernandez on 25/10/23.
//

import Foundation

struct CheckInNote : Identifiable{
    var id = UUID()
    var content: String
    var feeling: Int
    var date: Date
}
