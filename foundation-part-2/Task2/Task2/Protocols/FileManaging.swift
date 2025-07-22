import Foundation

protocol FileManaging {
    
    func contentsOfDirectory(at url: URL, includingPropertiesForKeys keys: [URLResourceKey]?, options: FileManager.DirectoryEnumerationOptions) throws -> [URL]
    func fileExists(atPath path: String) -> Bool
    func createDirectory(at url: URL, withIntermediateDirectories: Bool, attributes: [FileAttributeKey : Any]?) throws
    func removeItem(at url: URL) throws
    var temporaryDirectory: URL { get }
}

extension FileManager: FileManaging {}
