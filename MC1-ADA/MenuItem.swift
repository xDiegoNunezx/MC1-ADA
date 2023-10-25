//
//  MenuItem.swift
//  MC1-ADA
//
//  Created by Alejandro Oliva Ochoa on 20/10/23.
//

import Foundation
import SwiftUI

struct MenuItem: Identifiable {
    var id = UUID()
    var title: String
    var icon: String
    var stopsArray: [Gradient.Stop]
}
