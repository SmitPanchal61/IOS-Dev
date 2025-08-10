//
//  CurrencyIcon.swift
//  CurrencyConvertor
//
//  Created by Smit Mahesh Panchal on 6/19/25.
//

import SwiftUI

struct CurrencyIcon: View {
    
    var currencyImage: ImageResource
    var currencyName: String

    var body: some View {
            

            ZStack(alignment: .bottom) {
                Image(currencyImage)
                    .resizable()
                    .scaledToFit()
                
                Text(currencyName)
                    .font(.caption)
                    .padding(3)
                    .frame(maxWidth: .infinity)
                    .background(.brown.opacity(0.75))
            }
            .padding(3)
            .frame(width: 100, height: 100)
            .background(.brown)
            .clipShape(.rect(cornerRadius: 25))
                
                
        }
}


#Preview {
    CurrencyIcon(currencyImage: .goldpenny, currencyName: "Gold Penny")
}
