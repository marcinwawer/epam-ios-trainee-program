//
//  HomeViewModel.swift
//  GymScheduleApp
//
//  Created by Marcin Wawer on 27-06-2025.
//

import Foundation

class HomeViewModel {
    
    var sections: [GymClassSection] = []
    
    func load(classes: [GymClass]) {
        sections = groupClassesByDay(classes: classes)
    }
    
    private func groupClassesByDay(classes: [GymClass]) -> [GymClassSection] {
        var groupedDict: [Date: [GymClass]] = [:]
        let calendar = Calendar.current
        
        for gymClass in classes {
            let day = calendar.startOfDay(for: gymClass.date)
            groupedDict[day, default: []].append(gymClass)
        }
        
        var sections: [GymClassSection] = []
        for (date, classes) in groupedDict {
            let sortedClasses = classes.sorted { $0.date < $1.date }
            sections.append(GymClassSection(date: date, classes: sortedClasses))
        }
        
        sections.sort { $0.date < $1.date }
        return sections
    }
    
    func toggleRegistration(indexPath: IndexPath) {
        sections[indexPath.section].classes[indexPath.row].toggleRegistration()
    }
    
    func toggleFavorite(indexPath: IndexPath) {
        sections[indexPath.section].classes[indexPath.row].toggleFavorite()
    }
    
    func gymClass(indexPath: IndexPath) -> GymClass {
        return sections[indexPath.section].classes[indexPath.row]
    }
    
    func deleteClass(indexPath: IndexPath) {
        sections[indexPath.section].classes.remove(at: indexPath.row)
    }
}
