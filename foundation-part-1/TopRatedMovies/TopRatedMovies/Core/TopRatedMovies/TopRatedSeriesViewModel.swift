import Foundation
import Observation

@MainActor @Observable
final class TopRatedSeriesViewModel {
    
    var series: [Series] = []
    var isLoading = false
    var totalPages = 1
    
    private let service: SeriesService
    
    init(service: SeriesService = SeriesService()) {
        self.service = service
    }
    
    func loadSeries(page: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await service.fetchSeries(page: page)
            self.series = response.results
            self.totalPages = response.totalPages
        } catch {
            print(error)
        }
    }
}
