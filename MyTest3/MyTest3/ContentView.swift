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
    
    @State private var books = [Book]()
    @State private var isHidden = false
    @State private var hideBar = true
    
    let date : Date
    let df: DateFormatter
    
    let fontSize: CGFloat = 13
    var price: Float = 0.00

    init() {
        date = Date()
        df = DateFormatter()
        df.dateFormat = "MMM d, yyyy (EEE)"
        
        price = 1.25
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Text(date, formatter: df)
                        .font(.system(size: fontSize, weight: .light, design: .default))
                        .foregroundColor(.black)
                    Spacer()
                    let priceDisplay = String(format: "Total: ($) %0.2f", price)
                    Text(priceDisplay)
                        .font(.system(size: fontSize, weight: .light, design: .default))
                        .foregroundColor(.blue)
                }
                .padding(10)
                
                NavigationView {
                    List(books, id: \.id) { item in
                        NavigationLink(destination: DetailsView(selectedBook: item)) {
                            let title = "\(item.id), \(item.title)"
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(title)
                                    }.frame(height: 50)
                                }
                            }
                        }
                        .font(.system(size: 15))
                        .navigationBarHidden(hideBar)
                        .onAppear {
                            self.hideBar = true
                        }
                    }
                    .task {
                        await loadData()
                    }
                }
                .border(.black, width: 0.5)
            }

            VStack {
                ProgressView("Loading...")
                    .tint(.blue)
                    .isHidden(isHidden)
            }
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
