import SwiftUI

struct Task3View: View {
    
    private let photoSize: CGFloat = 100
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top) {
                placeholderImage
                nameSection
            }
            
            Text("""
                 Lorem ipsum dolor sit amet, consectetur 
                 adipiscing elit, sed do eiusmod tempor 
                 incididunt ut labore et dolore magna aliqua. 
                 """)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .navigationTitle("Task 3")
    }
}

extension Task3View {
    
    private var placeholderImage: some View {
        ProgressView()
            .frame(width: photoSize, height: photoSize)
            .background(.secondary.opacity(0.4))
            .clipShape(Circle())
    }
    
    private var nameSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Marcin")
                .font(.title3)
            
            Text("placeholder")
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack { Task3View() }
}
