import SwiftUI

struct DocumentView: View {
    
    @State private var vm = DocumentViewModel()
    @State private var presentEditor = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.files.isEmpty {
                    emptyView
                } else {
                    filesList
                }
                
                Button("Open Editor") {
                    presentEditor = true
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Text Files 📒")
        }
        .sheet(isPresented: $presentEditor, onDismiss: {
            vm.clear()
        }, content: {
            NavigationStack {
                editor
            }
        })
        .onAppear { vm.refreshFileList() }
    }
}

#Preview {
    DocumentView()
}

extension DocumentView {
    
    private var filesList: some View {
        List(vm.files, id: \.self) { name in
            Button(action: {
                vm.loadDocument(fileName: name)
                vm.inputText = vm.loadedText
                vm.fileName = name
                presentEditor = true
            }) {
                HStack {
                    Label(name, systemImage: "doc")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
        }
        .listStyle(.plain)
    }
    
    private var editor: some View {
        VStack(spacing: 20) {
            TextField("File Name (include .txt)", text: $vm.fileName)
                .textFieldStyle(.roundedBorder)
            
            TextEditor(text: $vm.inputText)
                .scrollContentBackground(.hidden)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.ultraThinMaterial)
                }
            
            Button(vm.inputText.isEmpty ? "Delete" : "Save") {
                if vm.updateDocument() {
                    presentEditor = false
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(vm.inputText.isEmpty ? .red : .blue)
        }
        .padding()
        .navigationTitle("✏️ Editor")
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text("Error"),
                  message: Text(vm.alertMessage ?? "Unknown error"),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    private var emptyView: some View {
        VStack(spacing: 20) {
            Image(systemName: "pencil.slash")
                .resizable()
                .frame(width: 100, height: 100)
            
            Text("No text files 😭")
                .font(.title3)
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .foregroundStyle(.secondary)
    }
}
