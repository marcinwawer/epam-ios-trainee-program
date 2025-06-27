//
//  GymClass.swift
//  GymScheduleApp
//
//  Created by Marcin Wawer on 27-06-2025.
//

import Foundation

struct GymClass {
    
    let name: String
    let date: Date
    let duration: TimeInterval
    let trainer: Trainer
    var isRegistered = false
    var isFavorite = false
    
    mutating func toggleFavorite() {
        isFavorite.toggle()
    }
    
    mutating func toggleRegistration() {
        isRegistered.toggle()
    }
}

struct GymClassSection {
    
    let date: Date
    var classes: [GymClass]
}
