import SwiftUI

@Observable
final class FormModel {
    
    var username = ""
}

struct Task5View: View {
    
    @State private var form: FormModel
    
    init(form: FormModel = FormModel()) {
        self.form = form
    }
    
    var body: some View {
        VStack(spacing: 20) {
            usernameSection
            
            Button("Log in") {
                print(form.username)
            }
            .buttonStyle(.borderedProminent)
            .disabled(form.username.isEmpty)
        }
        .padding()
        .navigationTitle("Task 5")
    }
}

#Preview {
    NavigationStack { Task5View() }
}

extension Task5View {
    
    private var usernameSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Label("Username", systemImage: "person.circle")
                .padding(.leading, 4)
            
            TextField("Username", text: $form.username, prompt: Text("Enter your username..."))
                .padding()
                .background(
                    .gray.opacity(0.2),
                    in: RoundedRectangle(cornerRadius: 10)
                )
        }
    }
}
