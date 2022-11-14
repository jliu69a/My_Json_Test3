//
//  ContentView.swift
//  MyTest3
//
//  Created by Johnson Liu on 11/14/22.
//

import SwiftUI

struct ContentView: View {
    @State var books = [Book]()
    
    var body: some View {
        
        List(books, id: \.id) { item in
            VStack(alignment: .leading) {
                Text(item.id)
                    .font(.headline)
                Text(item.title)
                HStack(alignment: .top) {
                    Text(item.author.last_name)
                    Text(", ")
                    Text(item.author.first_name)
                }
                HStack(alignment: .top) {
                    Text(item.author.location.city)
                    Text(", ")
                    Text(item.author.location.nation)
                }
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "http://www.mysohoplace.com/php_hdb/testing/load_data.php") else {
            print("Invalid URL.")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decoderResponse = try? JSONDecoder().decode([Book].self, from: data) {
                books = decoderResponse
            }
        } catch {
            print("Invalid Data.")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
