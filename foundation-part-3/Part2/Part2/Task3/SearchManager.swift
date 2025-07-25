import SwiftUI
import Observation

@Observable
final class SearchManager {
    
    private let key = "searchHistory"
    
    var searchHistory: [String] {
        didSet {
            UserDefaults.standard.set(searchHistory, forKey: key)
        }
    }
    
    init() {
        self.searchHistory = UserDefaults.standard.stringArray(forKey: key) ?? []
    }
    
    func add(_ term: String) {
        let trimmedTerm = term.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTerm.isEmpty else { return }
        
        var updated = searchHistory
        if updated.count >= 5 {
            updated.removeFirst()
        }
        
        updated.append(trimmedTerm)
        searchHistory = updated
    }
    
    func clear() {
        searchHistory = []
    }
}
