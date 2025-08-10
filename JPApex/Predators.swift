//
//  Predators.swift
//  JPApex
//
//  Created by Smit Mahesh Panchal on 6/28/25.
//

import Foundation

class Predators {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error Decoding the Data \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { predator1, predator2 in
            if alphabetical {
                predator1.name < predator2.name
            } else {
                predator1.id < predator2.id
            }
        }
    }
    
    func filterAll(by type: APType, movie: String?) {
        apexPredators = allApexPredators
        
        // Filter by APType
        if type != .all {
            apexPredators = apexPredators.filter { $0.type == type }
        }
        
        // Filter by Movie
        if let movie = movie {
            apexPredators = apexPredators.filter { $0.movies.contains(movie) }
        }
    }
    
//    func filterMovie(by movie: String?) {
//        if movie == nil {
//            apexPredators = allApexPredators
//        } else {
//            apexPredators = allApexPredators.filter { predator in
//                predator.movies.contains(movie!)
//            }
//        }
//    }
}
