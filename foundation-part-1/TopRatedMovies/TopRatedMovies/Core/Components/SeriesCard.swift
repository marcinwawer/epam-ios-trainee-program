import SwiftUI

struct SeriesCard: View {
    
    private enum Constants {
        static let posterWidth: CGFloat = 120
        static let posterHeight: CGFloat = 180
    }
    
    let series: Series
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 10) {
                poster
                
                VStack(alignment: .leading) {
                    Text(series.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    
                    seriesDetails
                        .font(.headline)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 8)
            
            Text(series.overview)
        }
    }
}

#Preview {
    SeriesCard(series: Series.mock)
        .padding()
}

extension SeriesCard {
    
    private var poster: some View {
        AsyncImage(url: series.posterURL()) { poster in
            poster
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.posterWidth, height: Constants.posterHeight)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } placeholder: {
            ProgressView()
                .frame(width: Constants.posterWidth, height: Constants.posterHeight)
                .background(.secondary.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    private var seriesDetails: some View {
        Group {
            Text("First air date: \(series.firstAirDate)")
            Text("Rating: \(String(format: "%.1f", series.voteAverage))")
            Text("Countries: \(series.originCountry.joined(separator: ", "))")
            Text("Popularity: \(String(format: "%.2f", series.popularity))")
        }
    }
}
