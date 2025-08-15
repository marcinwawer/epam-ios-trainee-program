import Foundation
import Combine
import Observation

@Observable
final class PostsViewModel {
    
    private(set) var posts: [Post] = []
    
    @ObservationIgnored private let service: PostsService
    @ObservationIgnored private var cancellables: Set<AnyCancellable> = []
    
    init(postsService: PostsService = PostsService()) {
        self.service = postsService
        addSubscribers()
    }
    
    private func addSubscribers() {
        service.$posts
            .map { $0 ?? [] }
            .sink { [weak self] in
                self?.posts = $0
            }
            .store(in: &cancellables)
    }
}
