//
//  ContentView.swift
//  BBQuotes
//
//  Created by Smit Mahesh Panchal on 7/7/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab(Constants.bbName, systemImage: "tortoise") {
                FetchView(show: Constants.bbName)
                    
            }
            
            Tab(Constants.bcsName, systemImage: "suitcase") {
                FetchView(show: Constants.bcsName)
                    
            }
            
            Tab(Constants.ecName, systemImage: "car") {
                FetchView(show: Constants.ecName)
                    
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
