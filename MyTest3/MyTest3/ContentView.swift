//
//  ContentView.swift
//  MyTest3
//
//  Created by Johnson Liu on 11/14/22.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}

struct ContentView: View {
    @State var books = [Book]()
    
    @State var isHidden = false
    
    let date : Date
    let df: DateFormatter
    
    init() {
        date = Date()
        df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd, (EEE)"
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Text("Books List:")
                    Text(date, formatter: df)
                }
                
                List(books, id: \.id) { item in
                    let name = "\(item.author.last_name), \(item.author.first_name)"
                    let place = "\(item.author.location.city), \(item.author.location.nation)"
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.id)
                                .font(.headline)
                            Text(item.title)
                            HStack(alignment: .top) {
                                Text(name)
                            }
                            HStack(alignment: .top) {
                                Text(place)
                            }
                        }
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                }
                .task {
                    await loadData()
                }
                .border(.red, width: 0.5)
            }

            VStack {
                ProgressView("Loading...")
                    .tint(.blue)
                    .isHidden(isHidden)
            }
        }
        .padding(10)
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
                
                isHidden = true
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
