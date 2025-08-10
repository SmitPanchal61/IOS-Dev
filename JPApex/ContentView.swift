//
//  ContentView.swift
//  JPApex
//
//  Created by Smit Mahesh Panchal on 6/28/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    let predators = Predators()
    var allMovies: [String] {
        let all = predators.allApexPredators.flatMap { $0.movies }
        return Array(Set(all)).sorted()
    }
    
    
    @State var searchText = ""
    @State var alphabetical = false
    @State var currenctSelection = APType.all
    @State var selectedMovie: String? = nil
    
    
    var filteredDinos: [ApexPredator] {
        predators.filterAll(by: currenctSelection, movie: selectedMovie)
        
        predators.sort(by: alphabetical)
        
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDinos) { predator in
                NavigationLink {
                    PredatorDetails(predator: predator, position: .camera(
                        MapCamera(
                        centerCoordinate: predator.location,
                        distance: 30000
                    )))
                } label: {
                    HStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading) {
                            
                            // name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            
                            //type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currenctSelection.animation()) {
                            ForEach(APType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("FilterMovies", selection: $selectedMovie.animation()) {
                            Text("All Movies").tag(String?.none)
                            
                            ForEach(allMovies, id: \.self) { movie in
                                Text(movie).tag(Optional(movie))
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
