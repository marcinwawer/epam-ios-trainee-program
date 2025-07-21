import Foundation

enum FileError: Error {
    
    case fileNotCreated
    case fileNotDecoded
}

struct FileService {
    
    private let fileManager: FileManaging
    private let documetsURL: URL
    
    init(fileManager: FileManaging = FileManager.default) {
        self.fileManager = fileManager
        documetsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func listTextFiles() throws -> [String] {
        let urls = try fileManager.contentsOfDirectory(at: documetsURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        return urls.filter { $0.pathExtension == "txt" }.map { $0.lastPathComponent }
    }
    
    func save(text: String, to fileName: String) throws {
        let fileURL = documetsURL.appendingPathComponent(fileName, conformingTo: .plainText)
        let path = fileURL.path
        let data = Data(text.utf8)
        
        if fileManager.fileExists(atPath: path) {
            try delete(fileName: fileName)
        }
        
        let fileCreated = fileManager.createFile(atPath: path, contents: nil, attributes: [.protectionKey: FileProtectionType.complete])
        
        guard fileCreated else {
            throw FileError.fileNotCreated
        }
        
        let handle = try FileHandle(forWritingTo: fileURL)
        try handle.write(contentsOf: data)
        try handle.close()
    }
    
    func loadText(from fileName: String) throws -> String {
        let fileURL = documetsURL.appendingPathComponent(fileName, conformingTo: .plainText)
        let handle = try FileHandle(forReadingFrom: fileURL)
        let data = try? handle.readToEnd()

        guard let data,
              let text = String(data: data, encoding: .utf8)
        else {
            throw FileError.fileNotDecoded
        }
        
        return text
    }
    
    func delete(fileName: String) throws {
        let fileURL = documetsURL.appendingPathComponent(fileName, conformingTo: .plainText)
        try fileManager.removeItem(at: fileURL)
    }
}
