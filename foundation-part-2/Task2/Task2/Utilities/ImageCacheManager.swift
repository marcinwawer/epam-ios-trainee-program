import SwiftUI

final class ImageCacheManager: ImageCache {
    
    private let fileManager: FileManaging
    private let session: URLSession
    private let cacheDirectory: URL
    private var memoryWarningObserver: NSObjectProtocol?
    
    init(fileManager: FileManaging = FileManager.default, session: URLSession = URLSession.shared) throws {
        self.fileManager = fileManager
        self.session = session
        
        self.cacheDirectory = fileManager.temporaryDirectory.appendingPathComponent("ImageCache", isDirectory: true)
        try ensureCacheDirectoryExists()
        subscribeToMemoryWarnings()
    }
    
    deinit {
        if let memoryWarningObserver {
            NotificationCenter.default.removeObserver(memoryWarningObserver)
        }
    }
    
    private func ensureCacheDirectoryExists() throws {
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    private func cacheFileURL(for url: URL) -> URL {
        let fileName = url.lastPathComponent
        return cacheDirectory.appendingPathComponent(fileName)
    }
    
    func imageData(for url: URL) async throws -> Data {
        let fileURL = cacheFileURL(for: url)
        if fileManager.fileExists(atPath: fileURL.path), let data = try? Data(contentsOf: fileURL) {
            print("image retrieved from cache")
            return data
        }
        
        let (data, _) = try await session.data(from: url)
        print("image downloaded from the internet")
        try data.write(to: fileURL, options: .atomic)
        return data
    }
    
    func clearCache() throws {
        let files = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: [])
        
        for file in files {
            try fileManager.removeItem(at: file)
        }
    }
    
    private func subscribeToMemoryWarnings() {
        memoryWarningObserver = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: .main) { [weak self] _ in
            do {
                try self?.clearCache()
                print("cache cleared on memory warning")
            } catch {
                print("cache clear fail on memory warning: ", error)
            }
        }
    }
}

