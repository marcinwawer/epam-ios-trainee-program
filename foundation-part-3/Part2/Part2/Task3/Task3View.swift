import SwiftUI

struct Task3View: View {
    
    @Environment(SearchManager.self) private var searchManager
    @State private var term = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Enter term", text: $term)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Search") {
                        searchManager.add(term)
                        term = ""
                    }
                    .disabled(term.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)
                
                List {
                    Text("Last 5 searches")
                        .foregroundStyle(.secondary)
                        .font(.headline)
                    
                    if searchManager.searchHistory.isEmpty {
                        Text("No recent searches")
                    } else {
                        ForEach(searchManager.searchHistory.reversed(), id: \.self) { Text($0) }
                    }
                }
                .listStyle(.plain)
                
                Button("Clear history") {
                    searchManager.clear()
                }
            }
            .navigationTitle("Search")
        }
    }
}

#Preview {
    NavigationStack {
        Task3View()
            .environment(SearchManager())
    }
}
