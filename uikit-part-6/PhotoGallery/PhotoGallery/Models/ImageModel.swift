//
//  ImageModel.swift
//  PhotoGallery
//
//  Created by Marcin Wawer on 29-06-2025.
//

import Foundation

struct ImageModel {
    
    let imageURL: String
    let title: String
    let date: Date
    var isFavorite = false
    
    mutating func toggleFavorite() {
        isFavorite.toggle()
    }
}

struct ImageModelSection {
    
    let date: Date
    var images: [ImageModel]
}
