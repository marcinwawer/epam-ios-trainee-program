import SwiftUI

struct Setting: Identifiable {
    
    let id = UUID()
    let name: String
    var isOn: Bool
}

enum SettingName: String, CaseIterable {
    
    case darkMode = "🌙 Dark Mode"
    case wiFi = "🛜 Wi-Fi"
    case bluetooth = "🔵 Bluetooth"
    case appleIntelligence = "🤖 Apple Intelligence"
}

struct Task6View: View {
    
    @State private var settings: [Setting] = SettingName.allCases.map { .init(name: $0.rawValue, isOn: false) }
    
    var body: some View {
        
        let darkMode = settings.first(where: { $0.name == SettingName.darkMode.rawValue})?.isOn ?? false
        
        List {
            Section("Settings") {
                ForEach($settings) { $setting in
                    Toggle(setting.name, isOn: $setting.isOn)
                }
            }
        }
        .navigationTitle("Task 6")
        .preferredColorScheme(darkMode ? .dark : .light)
    }
}

#Preview {
    NavigationStack { Task6View() }
}
