import SwiftUI

protocol ImageLoader {
    
    func imageNames() -> [String]
    func loadImage(name: String) -> UIImage?
}
