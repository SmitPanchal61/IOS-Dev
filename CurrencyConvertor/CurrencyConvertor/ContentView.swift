//
//  ContentView.swift
//  CurrencyConvertor
//
//  Created by Smit Mahesh Panchal on 6/18/25.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    @State var showExchangeInfo = false
    @State var showSelectedCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    var currencyTip = CurrencyTip()
    
    
    @State var leftCurrency: Currency = Currency(rawValue: UserDefaults.standard.double(forKey: "leftCurrency")) ?? .silverPiece
    @State var rightCurrency: Currency = Currency(rawValue: UserDefaults.standard.double(forKey: "rightCurrency")) ?? .goldPeice
    
    var body: some View {
        ZStack {
            // background
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                // picture
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.top, 20)
                
                // text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.bottom, -0.1)
                
                // convertor section
                HStack {
                    // left currency
                    VStack {
                        // currency title
                        
                        HStack {
                            // currency image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            // currency text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .onTapGesture {
                            showSelectedCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        .onChange(of: leftCurrency) {
                            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
                            UserDefaults.standard.set(leftCurrency.rawValue, forKey: "leftCurrency")
                        }
                        .popoverTip(currencyTip, arrowEdge: .bottom)
//                        .padding(.bottom, -2)
                        
                        // text field
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            .onChange(of: leftAmount) {
                                if leftTyping {
                                    rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
                                }
                            }
                    }
                    
                    // equal
                    Image(systemName: "equal")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .symbolEffect(.pulse)
                    
                    
                    // right currency
                    VStack {
                        // currency title
                        
                        HStack {
                            // currency text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            // currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .onTapGesture {
                            showSelectedCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        .onChange(of: rightCurrency) {
                            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
                            UserDefaults.standard.set(rightCurrency.rawValue, forKey: "rightCurrency")
                        }
//                        .padding(.bottom, -2)
                        
                        // text field
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                            .onChange(of: rightAmount) {
                                if rightTyping {
                                    leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
                                }
                            }
                    }
                }
                .padding(.vertical, 50)
                .padding(.horizontal, 15)
                .background(.black.opacity(0.3))
                .keyboardType(.decimalPad)
//                .border(.blue)
                
                Spacer()
                
                // info button
                HStack {
                    
                    Spacer()
                    
                    Button {
                        showExchangeInfo.toggle()
                        
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                    .sheet(isPresented: $showExchangeInfo) {
                        ExchangeInfo()
                    }
                    
                }

            }
            .onTapGesture {
                leftTyping = false
                rightTyping = false
            }
//            .border(.blue)
        }
        .task {
            try? Tips.configure()
        }
        .sheet(isPresented: $showSelectedCurrency) {
            SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
        }
    }
}

#Preview {
    ContentView()
}
