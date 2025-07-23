import Foundation

protocol BundleProtocol {
    
    func url(forResource resource: String?, withExtension extension: String?) -> URL?
    func urls(forResourcesWithExtension resourceWithExtension: String?, subdirectory: String?) -> [URL]?
}

extension Bundle: BundleProtocol {}
