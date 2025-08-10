//
//  ExchangeRate.swift
//  CurrencyConvertor
//
//  Created by Smit Mahesh Panchal on 6/19/25.
//

import SwiftUI

struct ExchangeRate: View {
    
    let leftImage: ImageResource
    
    let text: String
    
    let rightImage: ImageResource
    
    var body: some View {
        HStack {
            // left image
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            // middle text
            Text(text)
            
            // right image
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExchangeRate(leftImage: .silverpiece, text: "1 Silver Peice = 4 Silver Pennies", rightImage: .silverpenny)
}
