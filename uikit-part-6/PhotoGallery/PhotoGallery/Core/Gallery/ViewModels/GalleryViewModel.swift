//
//  GalleryViewModel.swift
//  PhotoGallery
//
//  Created by Marcin Wawer on 30-06-2025.
//

import UIKit

class GalleryViewModel {
    
    private(set) var sections: [ImageModelSection] = []
    
    func load(images: [ImageModel]) {
        sections = groupImagesByDay(images: images)
    }
    
    private func groupImagesByDay(images: [ImageModel]) -> [ImageModelSection] {
        var groupedDict: [Date: [ImageModel]] = [:]
        let calendar = Calendar.current
        
        for image in images {
            let day = calendar.startOfDay(for: image.date)
            groupedDict[day, default: []].append(image)
        }
        
        var sections: [ImageModelSection] = []
        for (date, images) in groupedDict {
            let sortedImages = images.sorted { $0.date < $1.date }
            sections.append(ImageModelSection(date: date, images: sortedImages))
        }
        
        sections.sort { $0.date < $1.date }
        return sections
    }
    
    func toggleFavorite(indexPath: IndexPath) {
        sections[indexPath.section].images[indexPath.row].toggleFavorite()
    }
    
    func ImageModel(indexPath: IndexPath) -> ImageModel {
        return sections[indexPath.section].images[indexPath.row]
    }
    
    func removeImage(at indexPath: IndexPath) {
        sections[indexPath.section].images.remove(at: indexPath.row)
        
        if sections[indexPath.section].images.isEmpty {
            sections.remove(at: indexPath.section)
        }
    }
}
