//
//  StringExt.swift
//  BBQuotes
//
//  Created by Smit Mahesh Panchal on 7/17/25.
//

extension String {
    
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeCaseAndSpace() -> String {
        self.removeSpaces().lowercased()
    }
}
