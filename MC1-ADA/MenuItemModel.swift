//
//  MenuItemModel.swift
//  MC1-ADA
//
//  Created by Alejandro Oliva Ochoa on 20/10/23.
//

import Foundation
import SwiftUI

class MenuItemModel{
    
    var mainMenu = [
        MenuItem(title: "Meditation", icon: "brain.head.profile", stopsArray: [
            Gradient.Stop(color: Color(red: 0.71, green: 0.86, blue: 0.60), location: 0.00),
            Gradient.Stop(color: Color(red: 0.95, green: 0.93, blue: 0.87), location: 0.79),
        ]),
        MenuItem(title: "Relaxation", icon: "character.duployan", stopsArray: [
            Gradient.Stop(color: Color(red: 0.65, green: 0.81, blue: 0.84).opacity(0.7), location: 0.00),
            Gradient.Stop(color: Color(red: 0.95, green: 0.93, blue: 0.87), location: 0.79),
        ]),
        MenuItem(title: "Journal", icon: "pencil.and.list.clipboard", stopsArray: [
            Gradient.Stop(color: Color(red: 0.98, green: 0.85, blue: 0.64).opacity(0.7), location: 0.00),
            Gradient.Stop(color: Color(red: 0.95, green: 0.93, blue: 0.87), location: 0.79),
        ]),
        MenuItem(title: "Check-in", icon: "plus.circle", stopsArray: [
            Gradient.Stop(color: Color(red: 0.29, green: 0.25, blue: 0.7).opacity(0.7), location: 0.00),
            Gradient.Stop(color: Color(red: 0.95, green: 0.93, blue: 0.87), location: 0.79),
        ])
    ]
}
