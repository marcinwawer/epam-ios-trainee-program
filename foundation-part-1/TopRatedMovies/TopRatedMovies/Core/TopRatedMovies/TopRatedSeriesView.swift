import SwiftUI

struct TopRatedSeriesView: View {
    
    @State private var vm = TopRatedSeriesViewModel()
    @State private var currentPage = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.isLoading {
                    ProgressView()
                } else {
                    List(vm.series) {
                        SeriesCard(series: $0)
                    }
                    .listStyle(.plain)
                }
                
                navigationButtons
                    .padding(.vertical, 4)
            }
            .navigationTitle("Top Series 🍿")
            .task {
                await vm.loadSeries(page: currentPage)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TopRatedSeriesView()
    }
}

extension TopRatedSeriesView {
    
    private var navigationButtons: some View {
        HStack {
            Button("Previous", systemImage: "arrow.uturn.backward") {
                guard currentPage > 1 else { return }
                currentPage -= 1
                
                Task {
                    await vm.loadSeries(page: currentPage)
                }
            }
            .disabled(currentPage == 1)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\(currentPage)")
            
            Button("Next", systemImage: "arrow.uturn.forward") {
                guard currentPage < vm.totalPages else { return }
                currentPage += 1
                
                Task {
                    await vm.loadSeries(page: currentPage)
                }
            }
            .disabled(currentPage == vm.totalPages)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(.ultraThinMaterial, in: .capsule)
        .padding(.horizontal)
        .padding(.bottom, 4)
    }
}
