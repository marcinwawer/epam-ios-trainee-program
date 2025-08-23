import SwiftUI

struct EmbeddedViewSUI: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Hello, from SwiftUI!")
                    .font(.title2)
                
                Button {
                    dismiss()
                } label: {
                    Label("Dismiss", systemImage: "xmark.circle.fill")
                        .font(.headline)
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("SwiftUI View")
            .padding()
        }
    }
}

#Preview {
    EmbeddedViewSUI()
}
