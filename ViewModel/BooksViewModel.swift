//
//  BooksViewModel.swift
//  BookApp_Practice01
//
//  Created by Ravindu Bandara on 2025-11-18.
//

import Foundation
import Observation
import SwiftUI

@Observable
class BooksViewModel {
    private let storage = UserDefaults.standard
    private let favoritesKey = AppStorageKeys.favoriteBooks
    
    var appsState: AppStates = .idele
    var bookResponse: BookResponse?
    var books: [Book] = []
    var errorMessage: String?
    var favoriteBooks: [Book] = []
    
    init() {
        refreshFavorites()
    }
    
    func fetchBooks() async {
        guard appsState != .loading else { return }
        
        appsState = .loading
        
        let urlString = "https://gutendex.com/books/"
        
        guard let url = URL(string: urlString) else {
            errorMessage = APIErrors.invalidURL.errorDescription
            appsState = .failure
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponses = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponses.statusCode) else {
                errorMessage = APIErrors.invalidResponse.errorDescription
                appsState = .failure
                return
            }
            
            let decodeData = try JSONDecoder().decode(BookResponse.self, from: data)
            bookResponse = decodeData
            books = decodeData.results
            appsState = .success
            
        } catch {
            errorMessage = APIErrors.unknown.errorDescription
            appsState = .failure
        }
    }
    
    func search(with text: String) {
        guard let allBooks = bookResponse?.results else { return }
        
        guard !text.isEmpty else {
            books = allBooks
            return
        }
        
        let lowercased = text.lowercased()
        
        books = allBooks.filter {
            $0.title.lowercased().contains(lowercased)
        }
    }
    
    func refreshFavorites() {
        favoriteBooks = loadFavorites()
    }
    
    func toggleFavorite(_ book: Book) {
        if let index = favoriteBooks.firstIndex(where: { $0.title == book.title }) {
            favoriteBooks.remove(at: index)
        } else {
            favoriteBooks.append(book)
        }
        persistFavorites()
    }
    
    func removeFavorite(at offsets: IndexSet) {
        favoriteBooks.remove(atOffsets: offsets)
        persistFavorites()
    }
    
    func isFavorite(_ book: Book) -> Bool {
        favoriteBooks.contains { $0.title == book.title }
    }
    
    private func loadFavorites() -> [Book] {
        guard let data = storage.data(forKey: favoritesKey),
              let decoded = try? JSONDecoder().decode([Book].self, from: data) else {
            return []
        }
        return decoded
    }
    
    private func persistFavorites() {
        guard let data = try? JSONEncoder().encode(favoriteBooks) else { return }
        storage.set(data, forKey: favoritesKey)
    }
}
