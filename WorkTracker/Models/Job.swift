//
//  Job.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Job {
    var id: UUID
    var name: String
    var colorHex: String
    
    @Transient
    var color: Color {
        get { Color(hex: colorHex) }
        set { colorHex = newValue.toHex() }
    }
    
    init(id: UUID = UUID(), name: String, color: Color = .blue) {
        self.id = id
        self.name = name
        self.colorHex = color.toHex()
    }
}
