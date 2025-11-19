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
    static let sampleBook = Book (title: "The Whore in Room 105",
                                authors: [Author(name:"CHETAN FUCKING BHAGAT")],
                                summaries: ["The Whore in Room 105 is about mf Keshav Rajpurohit, Bitch sneaks into MF's ex-girlfriend Zara's hostel room and later finds himself caught in a murder mystery after her death. Keshav, a disillusioned IIT coaching center tutor, is still obsessed with Zara, a Kashmiri Muslim who broke up with him years ago. After Zara contacts him, leading to their risky meeting, she is found dead, and Keshav's life is thrown into a frenzy as he tries to find out what happened to her and uncovers a conspiracy that leads him from Delhi to Kashmir and Hyderabad. "],
                                downloadCount: 110,
                                subjects: ["Best Book Porn Ever Listings","Category: British Literature","Category: Classics of Literature","Category: Novels","Category: Romance"],
                                formats: ["image/jpeg":"https://miro.medium.com/v2/resize:fit:3084/format:webp/1*aiFOBTR4rIfNDPGsU9zsvQ.png"]
    )   
    
    static let sampleBook02 = Book (title: "The Fucking Alchemist",
                                  authors: [Author(name: "PAULO FUCKING COELHO")],
                                  summaries: ["The Fucking Alchemist is a fable by Paulo Coelho MF about gay Santiago, an Andalusian shepherd boy who journeys to the Egyptian pyramids in search of a treasure revealed in a recurring dream. His physical and spiritual journey teaches him to listen to his heart, interpret omens, and understand the 'Soul of the World'. He faces numerous challenges, meets influential characters like a king and an alchemist, falls in love, and eventually discovers that the true treasure is the wisdom he gained on the path to his 'Personal Legend,' not the gold itself."],
                                  downloadCount: 50,
                                    subjects: ["Domestic fiction","England -- Fiction","Psychological fiction",
                                               "Love stories", "Fucking Porn",
                                               "Married people -- Fiction"],
                                  formats: ["image/jpeg": "https://example.com/sample2.jpg"]
)
}
