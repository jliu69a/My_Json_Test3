//
//  DetailsView.swift
//  MyTest3
//
//  Created by Johnson Liu on 11/15/22.
//

import SwiftUI

struct DetailsView: View {
    
    var selectedBook: Book
    
    var body: some View {
        VStack {
            HStack {
                Text("Book: \(selectedBook.title)")
                Spacer()
            }
            .padding(10)
            
            HStack {
                Text("Author: \(selectedBook.author.first_name) \(selectedBook.author.last_name)")
                Spacer()
            }
            .padding(10)

            HStack {
                Text("Pulished at: \(selectedBook.author.location.city), \(selectedBook.author.location.nation)")
                Spacer()
            }
            .padding(10)

            Spacer()
        }
        .border(.blue, width: 0.5)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(selectedBook: Book.empty)
    }
}
