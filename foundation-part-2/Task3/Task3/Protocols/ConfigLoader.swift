import SwiftUI

protocol ConfigLoader {
    
    func loadConfig() throws -> AppConfig
}
