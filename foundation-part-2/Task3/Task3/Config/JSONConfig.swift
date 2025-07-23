import Foundation

enum ConfigError: Error {
    
    case missingFile
}

struct JSONConfig: ConfigLoader {
    
    private let bundle: BundleProtocol
    private let fileName: String
    private let fileExtension: String
    
    init(bundle: BundleProtocol = Bundle.main, fileName: String = "config", fileExtension: String = "json") {
        self.bundle = bundle
        self.fileName = fileName
        self.fileExtension = fileExtension
    }
    
    func loadConfig() throws -> AppConfig {
        guard let url = bundle.url(forResource: fileName, withExtension: fileExtension) else {
            throw ConfigError.missingFile
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(AppConfig.self, from: data)
    }
}
