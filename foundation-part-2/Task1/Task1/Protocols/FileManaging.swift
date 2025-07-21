import Foundation

protocol FileManaging {
    
    func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL]
    func contentsOfDirectory(at url: URL, includingPropertiesForKeys keys: [URLResourceKey]?, options: FileManager.DirectoryEnumerationOptions) throws -> [URL]
    func createFile(atPath path: String, contents: Data?, attributes: [FileAttributeKey : Any]?) -> Bool
    func fileExists(atPath path: String) -> Bool
    func removeItem(at url: URL) throws
}

extension FileManager: FileManaging {}
