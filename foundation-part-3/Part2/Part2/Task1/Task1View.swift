import SwiftUI

struct Task1View: View {
    
    @Environment(ThemeManager.self) private var themeManager: ThemeManager
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: Binding(
                        get: { themeManager.isDarkMode },
                        set: { themeManager.isDarkMode = $0 }
                    ))
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    NavigationStack {
        Task1View()
            .environment(ThemeManager())
    }
}
