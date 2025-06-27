//
//  DeveloperPreview.swift
//  GymScheduleApp
//
//  Created by Marcin Wawer on 27-06-2025.
//

import Foundation

final class DeveloperPreview {
    
    static let shared = DeveloperPreview()
    
    private let trainerAnna = Trainer(
        name: "Anna",
        surname: "Kowalska",
        profilePhotoURL: "anna"
    )
    
    private let trainerJohn = Trainer(
        name: "John",
        surname: "Smith",
        profilePhotoURL: "john"
    )
    
    let gymClasses: [GymClass]
    
    private init() {
        gymClasses = [
            GymClass(
                name: "Morning Yoga",
                date: Calendar.current.date(byAdding: .day, value: 0, to: Date())!,
                duration: 60 * 60,
                trainer: trainerAnna
            ),
            GymClass(
                name: "CrossFit Blast",
                date: Calendar.current.date(byAdding: .day, value: 0, to: Date())!,
                duration: 45 * 60,
                trainer: trainerJohn
            ),
            GymClass(
                name: "Pilates Core",
                date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                duration: 50 * 60,
                trainer: trainerAnna
            ),
            GymClass(
                name: "Evening Spinning",
                date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                duration: 40 * 60,
                trainer: trainerJohn
            ),
            GymClass(
                name: "HIIT Power",
                date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                duration: 30 * 60,
                trainer: trainerAnna
            ),
            GymClass(
                name: "Zumba Dance",
                date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                duration: 55 * 60,
                trainer: trainerJohn
            ),
            GymClass(
                name: "Stretch & Relax",
                date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                duration: 35 * 60,
                trainer: trainerAnna
            )
        ]
    }
}
