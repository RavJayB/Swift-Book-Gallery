//
//  BookResponse.swift
//  BookApp_Practice01
//
//  Created by Ravindu Bandara on 2025-11-18.
//

import Foundation

struct BookResponse: Codable {
    let results : [Book]
}

struct Book: Codable, Identifiable {
    let id = UUID()
    let title: String
    let authors: [Author]
    let summaries: [String]
    let downloadCount: Int
    let subjects: [String]
    let formats: [String: String]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case authors
        case summaries
        case downloadCount = "download_count"
        case subjects
        case formats
    }
    
    var coverImageURL: String? {
        formats?["image/jpeg"]
    }
}

struct Author: Codable, Identifiable {
    let id = UUID()
    let name: String
}

extension Book {
    static let sampleBook = Book (
                                  title: "The Girl at Room 105",
                                  authors: [Author(name: "CHETAN BHAGET")],
                                  summaries: ["Some random shit that I truly dont remember"],
                                  downloadCount: 10,
                                  subjects: ["Domestic fiction","England -- Fiction","Psychological fiction",
                                             "Love stories",
                                             "Married people -- Fiction"],
                                  formats: ["image/jpeg": "https://example.com/sample.jpg"]
    )
    
    static let sampleBook02 = Book (title: "The Alchemist",
                                  authors: [Author(name: "PAULO COELHO")],
                                  summaries: ["The Alchemist is a fable by Paulo Coelho about Santiago, an Andalusian shepherd boy who journeys to the Egyptian pyramids in search of a treasure revealed in a recurring dream. His physical and spiritual journey teaches him to listen to his heart, interpret omens, and understand the 'Soul of the World'. He faces numerous challenges, meets influential characters like a king and an alchemist, falls in love, and eventually discovers that the true treasure is the wisdom he gained on the path to his 'Personal Legend,' not the gold itself."],
                                  downloadCount: 50,
                                    subjects: ["Domestic fiction","England -- Fiction","Psychological fiction",
                                               "Love stories",
                                               "Married people -- Fiction"],
                                  formats: ["image/jpeg": "https://example.com/sample2.jpg"]
)
}
