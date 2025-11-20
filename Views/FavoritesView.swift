//
//  FavoritesView.swift
//  BookApp_Practice01
//
//  Created by Ravindu Bandara on 2025-11-19.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(BooksViewModel.self) private var viewModel
    
    var body: some View {
        Group {
            if viewModel.favoriteBooks.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "bookmark.slash")
                        .font(.system(size: 48))
                        .foregroundStyle(.secondary)
                    Text("No saved books yet")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("Tap the bookmark icon in a book to add it to your favorites.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(viewModel.favoriteBooks) { book in
                        NavigationLink {
                            BookDetails(book: book)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text("\(book.downloadCount) Downloads")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.removeFavorite)
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("Favorites")
        .onAppear {
            viewModel.refreshFavorites()
        }
    }
}

#Preview {
    NavigationStack {
        FavoritesView()
            .environment(BooksViewModel())
    }
}