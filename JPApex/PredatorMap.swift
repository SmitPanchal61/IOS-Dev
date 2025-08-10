//
//  PredatorMap.swift
//  JPApex
//
//  Created by Smit Mahesh Panchal on 7/4/25.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    
    let predators = Predators()
    
    @State var position: MapCameraPosition
    @State var satellite = false
    @State private var selectedPredator: ApexPredator? = nil
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(predators.apexPredators) { predator in
                    Annotation(predator.name, coordinate: predator.location) {
                        Button {
                            selectedPredator = predator
                        } label: {
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .shadow(color: .white, radius: 3)
                                .scaleEffect(x: -1)
                        }
                    }
                }
            }
            .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
            .overlay(alignment: .bottomTrailing) {
                Button {
                    satellite.toggle()
                } label: {
                    Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                        .font(.largeTitle)
                        .imageScale(.large)
                        .padding(3)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 7))
                        .shadow(radius: 3)
                        .padding()
                }
            }
            
            if let predator = selectedPredator {
                VStack {
                        Spacer()
                        VStack(spacing: 10) {
                            Text(predator.name)
                                .font(.title2)
                                .bold()
                                .foregroundColor(.primary)
                            Text("\(predator.type.rawValue.capitalized) Predator")
                                .font(.title3)
                            Button("Close") {
                                selectedPredator = nil
                            }
                            .font(.title2)
                            .bold()
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                        .shadow(radius: 10)
                        .padding()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                    
                
                
            }
            
                
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(position:  .camera(MapCamera(
        centerCoordinate: Predators().apexPredators[2].location,
        distance: 1000,
        heading: 250,
        pitch:  80))
    )
    .preferredColorScheme(.dark)
}
