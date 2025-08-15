import Foundation
import Combine

struct PostAPI {
    
    static let baseURLString = "https://jsonplaceholder.typicode.com"
    static let posts = baseURLString.appending("/posts")
}

protocol PostsServiceProtocol {
    
    func fetchPosts()
}

final class PostsService: PostsServiceProtocol {
    
    @Published private(set) var posts: [Post]?
    
    private let manager: NetworkingManager
    private(set) var postsDataSub: AnyCancellable?
    
    init(manager: NetworkingManager = NetworkingManager()) {
        self.manager = manager
        fetchPosts()
    }
    
    func fetchPosts() {
        guard let url = URL(string: PostAPI.posts) else { return }
        
        postsDataSub = manager.download(for: url)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] in
                guard let self else { return }
                self.posts = $0
                self.postsDataSub?.cancel()
            })
    }
}
