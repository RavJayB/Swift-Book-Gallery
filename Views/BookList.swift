//
//  BookList.swift
//  BookApp_Practice01
//
//  Created by Ravindu Bandara on 2025-11-18.
//

import SwiftUI

struct BooksList: View {
    let books: [Book]
    
    var body: some View {
//        List(books) { book in
//            NavigationLink{
//                //todo
//                BookDetails(book: book)
//            }
//            label: {
//                VStack(alignment: .leading){
//                    Text(book.title)
//                        .font(.title3)
//                        .fontWeight(.bold)
//                    Text("\(book.downloadCount) downloads")
//                        .foregroundStyle(.secondary)
//                }
//            }
//        }
        
        List(books){ book in
            NavigationLink{
                BookDetails(book: book)
            }
            label: {
                VStack(alignment: .leading){
                    
                    Text(book.title)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("\(book.downloadCount) Downloads")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        BooksList(books: [.sampleBook, .sampleBook02])
    }
}
