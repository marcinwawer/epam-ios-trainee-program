import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "gear")
                .font(.largeTitle)
            
            Text("Settings View")
                .font(.title)
            
            Button("Go back") {
                dismiss()
            }
            .buttonStyle(.bordered)
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack { SettingsView() }
}
