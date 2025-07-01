//
//  DeveloperPreview.swift
//  PhotoGallery
//
//  Created by Marcin Wawer on 29-06-2025.
//

import Foundation

final class DeveloperPreview {
    
    static let shared = DeveloperPreview()
    
    private init() { }
    
    let images: [ImageModel] = [
        ImageModel(
            imageURL: "cat-1",
            title: "Very long title very very very long title ...",
            date: Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        ),
        ImageModel(
            imageURL: "cat-2",
            title: "Gray Cat",
            date: Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        ),
        ImageModel(
            imageURL: "cat-3",
            title: "White Cat",
            date: Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        ),
        ImageModel(
            imageURL: "cat-4",
            title: "Tuxedo Cat",
            date: Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        ),
        ImageModel(
            imageURL: "cat-5",
            title: "Sitting Cat",
            date: Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        ),
        ImageModel(
            imageURL: "cat-1",
            title: "Playful Cat",
            date: Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        ),
        ImageModel(
            imageURL: "cat-1",
            title: "Sleepy Cat",
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        ),
        ImageModel(
            imageURL: "cat-4",
            title: "Curious Cat",
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        ),
        ImageModel(
            imageURL: "cat-2",
            title: "Jumping Cat",
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        ),
        ImageModel(
            imageURL: "cat-5",
            title: "Stretching Cat",
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        ),
        ImageModel(
            imageURL: "cat-5",
            title: "Yawning Cat",
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        ),
        ImageModel(
            imageURL: "cat-3",
            title: "Hiding Cat",
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        ),
        ImageModel(
            imageURL: "cat-1",
            title: "Chasing Cat",
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        )
    ]
}
