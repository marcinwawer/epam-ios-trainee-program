import SwiftUI
import Observation

@Observable
final class ThemeManager {
    
    private let key = "isDarkMode"
    
    var isDarkMode: Bool {
        didSet { UserDefaults.standard.set(isDarkMode, forKey: key) }
    }
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: key)
    }
}
