//
//  CurrencyTip.swift
//  CurrencyConvertor
//
//  Created by Smit Mahesh Panchal on 6/21/25.
//

import TipKit

struct CurrencyTip: Tip {
    var title = Text("Change Currency")
    
    var message: Text? = Text("You can tap on the left or right currency to bring up the Select Currency screen.")
                              
    var image: Image? = Image(systemName: "hand.tap.fill")
}
