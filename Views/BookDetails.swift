//
//  BookDetails.swift
//  BookApp_Practice01
//
//  Created by Ravindu Bandara on 2025-11-18.
//

import SwiftUI

struct BookDetails: View {
    let book: Book
    @AppStorage(AppStorageKeys.favoriteBooks) private var favoriteBooksData: Data = Data()
    @State private var isFavorite = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {


                if let coverImageURL = book.coverImageURL,
                let url = URL(string: coverImageURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable().scaledToFit()
                        case .failure(_):
                            Image(systemName: "book.closed")
                        case .empty:
                            ProgressView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(height: 200)
                }
                
                Text(book.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("\(book.downloadCount) Downloads")
                    .foregroundStyle(.secondary)
                
                VStack(spacing: 8) {
                    Text("Authors")
                        .font(.title2)
                        .fontWeight(.bold)
                    ForEach(book.authors) { author in
                        Text(author.name)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                
                Divider()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Summery")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ForEach(Array(book.summaries.enumerated()), id: \.offset) { _, summary in
                        Text(summary)
                            .multilineTextAlignment(.leading)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                GroupBox {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Subjects")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(book.subjects.joined(separator: ", "))
                            .multilineTextAlignment(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle("Book Details")
        .navigationBarTitleDisplayMode(.inline)

        // ---------------------------------
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                }
                .accessibilityLabel(isFavorite ? "Remove from favorites" : "Save to favorites")
            }
        }
        .onAppear {
            isFavorite = isBookFavorite()
        }
    }
    
    private func toggleFavorite() {
        var favorites = loadFavorites()
        if isBookFavorite() {
            favorites.removeAll { $0.title == book.title }
            isFavorite = false
        } else {
            favorites.append(book)
            isFavorite = true
        }
        saveFavorites(favorites)
    }
    
    private func loadFavorites() -> [Book] {
        guard let favorites = try? JSONDecoder().decode([Book].self, from: favoriteBooksData) else {
            return []
        }
        return favorites
    }
    
    private func saveFavorites(_ favorites: [Book]) {
        favoriteBooksData = (try? JSONEncoder().encode(favorites)) ?? Data()
    }
    
    private func isBookFavorite() -> Bool {
        loadFavorites().contains { $0.title == book.title }
    }
}

#Preview {
    NavigationStack {
        BookDetails(book: .sampleBook)
    }
}
