import SwiftUI
import Combine

struct Task9View: View {
    
    @State private var vm = PostsViewModel()
    
    var body: some View {
        Group {
            if vm.posts.isEmpty {
                ProgressView()
            } else {
                postsList
            }
        }
        .navigationTitle("Task 9")
    }
}

#Preview {
    NavigationStack { Task9View() }
}

extension Task9View {
    
    private var postsList: some View {
        List(vm.posts) { post in
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(Image(systemName: "note.text"))
                    
                    Text(post.title)
                        .lineLimit(1)
                        .font(.headline)
                }
                .foregroundStyle(.blue)
                
                HStack {
                    Text(Image(systemName: "person.circle"))
                    
                    Text("\(post.userId)")
                        .font(.headline)
                }
                .padding(.bottom)
                
                Text(post.body)
            }
        }
    }
}
