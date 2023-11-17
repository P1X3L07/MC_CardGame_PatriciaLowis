//
//  ContentView.swift
//  AFL2_Card Game_Patricia Lowis
//
//  Created by MacBook Pro on 15/11/23.
//

import SwiftUI
import Foundation

struct Card: Codable {
    let object: String
    let total_cards: Int
    let has_more: Bool
    let data: [CardData]
}

struct CardData: Codable {
    let object: String?
    let id: String?
    let oracle_id: String?
    let multiverse_ids: [Int]?
    let mtgo_id: Int?
    let arena_id: Int?
    let tcgplayer_id: Int?
    let cardmarket_id: Int?
    let name: String?
    let lang: String?
    let released_at: String?
    let uri: String?
    let scryfall_uri: String?
    let layout: String?
    let highres_image: Bool?
    let image_status: String?
    let image_uris: ImageURIs?
    let mana_cost: String?
    let cmc: Double?
    let type_line: String?
    let oracle_text: String?
    let colors: [String]?
    let color_identity: [String]?
    let keywords: [String]?
    let legalities: Legalities?
    let games: [String]?
    let reserved: Bool?
    let foil: Bool?
    let nonfoil: Bool?
    let finishes: [String]?
    let oversized: Bool?
    let promo: Bool?
    let reprint: Bool?
    let variation: Bool?
    let set_id: String?
    let set: String?
    let set_name: String?
    let set_type: String?
    let set_uri: String?
    let set_search_uri: String?
    let scryfall_set_uri: String?
    let rulings_uri: String?
    let prints_search_uri: String?
    let collector_number: String?
    let digital: Bool?
    let rarity: String?
    let flavor_text: String?
    let card_back_id: String?
    let artist: String?
    let artist_ids: [String]?
    let illustration_id: String?
    let border_color: String?
    let frame: String?
    let frame_effects: [String]?
    let security_stamp: String?
    let full_art: Bool?
    let textless: Bool?
    let booster: Bool?
    let story_spotlight: Bool?
    let promo_types: [String]?
    let edhrec_rank: Int?
    let penny_rank: Int?
    let prices: Prices?
    let related_uris: RelatedURIs?
    let purchase_uris: PurchaseURIs?
}

struct ImageURIs: Codable {
    let small: String?
    let normal: String?
    let large: String?
    let png: String?
    let art_crop: String?
    let border_crop: String?
}

struct Legalities: Codable {
    let standard: String?
    let future: String?
    let historic: String?
    let gladiator: String?
    let pioneer: String?
    let explorer: String?
    let modern: String?
    let legacy: String?
    let pauper: String?
    let vintage: String?
    let penny: String?
    let commander: String?
    let oathbreaker: String?
    let brawl: String?
    let historicbrawl: String?
    let alchemy: String?
    let paupercommander: String?
    let duel: String?
    let oldschool: String?
    let premodern: String?
    let predh: String?
}

struct Prices: Codable {
    let usd: String?
    let usd_foil: String?
    let usd_etched: String?
    let eur: String?
    let eur_foil: String?
    let tix: String?
}

struct RelatedURIs: Codable {
    let gatherer: String?
    let tcgplayer_infinite_articles: String?
    let tcgplayer_infinite_decks: String?
    let edhrec: String?
}

struct PurchaseURIs: Codable {
    let tcgplayer: String?
    let cardmarket: String?
    let cardhoarder: String?
}

struct ContentView: View {
    @State var dataCards: [CardData] = []
    @State var searchCard: String = ""

    func loadJSONData() {
           if let bundlePath = Bundle.main.path(forResource: "WOT-Scryfall", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: bundlePath)) {
               do {
                   let decoder = JSONDecoder()
                   let result = try decoder.decode(Card.self, from: jsonData)
             
                   dataCards = result.data
               } catch {
                   print(error)
               }
           }
       }
    
    var filteredCards: [CardData] {
            if searchCard.isEmpty {
                return dataCards
            } else {
                return dataCards.filter { $0.name?.lowercased().contains(searchCard.lowercased()) ?? false }
            }
        }
    
    var body: some View {
            NavigationView {
                List {
                    SearchBar(text: $searchCard)

                    ForEach(filteredCards, id: \.id) { card in
                        NavigationLink(destination: CardDetailedView(DetailedView: card)) {
                            CardRow(card: card)
                        }
                    }
                }
                .navigationTitle("Cards")
                .onAppear {
                    loadJSONData()
                }
            }
        }
}

struct CardRow: View {
    var card: CardData

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
//            Text(card.name ?? "Unknown")
//                .font(.title)
//                .fontWeight(.bold)
//                .foregroundColor(.black)
//            Text(card.type_line ?? "Unknown")
//                .font(.subheadline)
//                .fontWeight(.light)
//                .foregroundColor(.black)
//            Text(card.oracle_text ?? "Unknown")
//                .font(.subheadline)
//                .fontWeight(.light)
//                .foregroundColor(.black)
            
            AsyncImage(url: URL(string: card.image_uris?.normal ?? "https://via.placeholder.com/150")!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                VStack(alignment: .trailing, spacing: 10){
                    Text(card.name ?? "Unknown")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                }
            }
            
        placeholder: {
                ProgressView()
            }
        }
        .padding()
    }
}


struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) 
                            {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .autocapitalization(.none)
        }
    }
}

#Preview {
    ContentView()
}

struct CardDetailedView: View {
    var DetailedView: CardData
    @State private var isImageFullScreen = false
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                AsyncImage(url: URL(string: DetailedView.image_uris?.normal ?? "https://via.placeholder.com/150")!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.width / 6) // Set the desired height (1/4 size)
                        .onTapGesture {
                            isImageFullScreen.toggle()
                        }
                } placeholder: {
                    ProgressView()
                }
                .sheet(isPresented: $isImageFullScreen) {
                    // Full-screen popup with the image
                    ImagePopupView(imageURL: URL(string: DetailedView.image_uris?.normal ?? "")!)
                }
            }
            .frame(height: UIScreen.main.bounds.height / 8)
            .background(Color.black)
            
            Spacer()
            
            VStack(alignment: .center, spacing: 8) {
                Text(DetailedView.type_line ?? "Unknown")
                    .fontWeight(.semibold)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .center)

                Text("Released at: \(DetailedView.released_at!)")
                    .fontWeight(.semibold)
                    .font(.title3)
                    .padding()

                Text("Description")
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .center)

                Text(DetailedView.oracle_text!)
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
            }
            .foregroundColor(.black) // Optional: Set text color
            .padding()
            .background(Color.white)
        }
    }
}

struct ImagePopupView: View {
    var imageURL: URL

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        // Close the full-screen popup on tap
                        // You can customize this part based on your requirements
                    }
            )
        }
    }
}
