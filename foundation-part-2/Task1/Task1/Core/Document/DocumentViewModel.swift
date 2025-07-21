import Foundation
import Observation

@MainActor @Observable
final class DocumentViewModel {
    
    var fileName = ""
    var inputText = ""
    var alertMessage: String?
    var showAlert = false
    private(set) var loadedText = ""
    private(set) var files: [String] = []
    
    @ObservationIgnored private let fileService: FileService
    
    init(fileService: FileService = FileService()) {
        self.fileService = fileService
    }
    
    func clear() {
        fileName = ""
        inputText = ""
        loadedText = ""
    }
    
    func refreshFileList() {
        do {
            files = try fileService.listTextFiles()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateDocument() -> Bool {
        guard !fileName.isEmpty,
              fileName.lowercased().hasSuffix(".txt")
        else {
            presentAlert(message: "File name must end with .txt")
            return false
        }
        
        guard fileName.first != "." else {
            presentAlert(message: "File name cannot start with '.'")
            return false
        }
        
        defer { refreshFileList() }
        
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        do {
            if trimmed.isEmpty {
                try fileService.delete(fileName: fileName)
            } else {
                try fileService.save(text: inputText, to: fileName)
            }
        } catch {
            presentAlert(error: error)
            return false
        }
        
        return true
    }
    
    func loadDocument(fileName: String) {
        do {
            loadedText = try fileService.loadText(from: fileName)
        } catch {
            presentAlert(error: error)
        }
    }
    
    private func presentAlert(error: Error) {
        alertMessage = error.localizedDescription
        showAlert = true
    }
    
    private func presentAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}
