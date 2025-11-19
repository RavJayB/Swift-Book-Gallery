//
//  FavoritesViewModel.swift
//  BookApp_Practice01
//
//  Created by Ravindu Bandara on 2025-11-19.
//

import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
class FavoritesViewModel {
    private let storage = UserDefaults.standard
    private let storageKey = AppStorageKeys.favoriteBooks
    
    var favoriteBooks: [Book] = []
    
    init() {
        decodeFavorites()
    }
    
    func refresh() {
        decodeFavorites()
    }
    
    func deleteFavorite(at offsets: IndexSet) {
        favoriteBooks.remove(atOffsets: offsets)
        persistFavorites()
    }
    
    private func decodeFavorites() {
        guard let data = storage.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([Book].self, from: data) else {
            favoriteBooks = []
            return
        }
        favoriteBooks = decoded
    }
    
    private func persistFavorites() {
        guard let data = try? JSONEncoder().encode(favoriteBooks) else { return }
        storage.set(data, forKey: storageKey)
    }
}

