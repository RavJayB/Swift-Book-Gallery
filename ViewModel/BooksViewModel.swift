//
//  BooksViewModel.swift
//  BookApp_Practice01
//
//  Created by Ravindu Bandara on 2025-11-18.
//

import Foundation
import Observation

@Observable

class BooksViewModel{
    var appsState: AppStates = .idele
    var bookResponse : BookResponse?
    var books : [Book] = []
    var errorMessage : String?
    
    func fetchBooks() async {
        guard appsState != .loading else {return}
        
        appsState = .loading
        
        let urlString = "https://gutendex.com/books/"
        
        guard let url = URL(string: urlString) else {
            //handle errors
            errorMessage = APIErrors.invalidURL.errorDescription
            appsState = .failure
            //
            return
        }
        
        do {
            let(data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponses = response as? HTTPURLResponse,
                    (200..<300).contains(httpResponses.statusCode) else {
                //handle errors
                errorMessage = APIErrors.invalidResponse.errorDescription
                appsState = .failure
                //
                return
            }
            
            let decodeData = try JSONDecoder().decode(BookResponse.self, from: data)
            bookResponse = decodeData
            books = decodeData.results
            appsState = .success
            
        }catch{
            //handle errors here
            errorMessage = APIErrors.unknown.errorDescription
            appsState = .failure
            //
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
    
    
}
