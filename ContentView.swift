//
//  ContentView.swift
//  BookApp_Practice01
//
//  Created by Ravindu Bandara on 2025-11-18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText = ""
    @State private var viewModel = BooksViewModel()
    
    var body: some View {
        TabView {
            NavigationStack {
                VStack {
                    switch viewModel.appsState {
                    case .idele:
                        EmptyView()
                    case .loading:
                        ProgressView()
                    case .success:
                        BooksList(books: viewModel.books)
                    case .failure:
                        Text(viewModel.errorMessage ?? "Something went wrong..!")
                    }
                }
                .navigationTitle("Books App")
                .task {
                    await viewModel.fetchBooks()
                }
                .searchable(text: $searchText, prompt: "Search books")
                .onChange(of: searchText) { newValue in
                    viewModel.search(with: newValue)
                }
            }
            .tabItem {
                Label("Browse", systemImage: "book")
            }
            
            NavigationStack {
                FavoritesView()
            }
            .tabItem {
                Label("Favorites", systemImage: "bookmark.fill")
            }
        }
        .environment(viewModel)
    }
        
}

#Preview {
    ContentView()
}
