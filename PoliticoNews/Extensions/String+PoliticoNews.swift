//
//  String+PoliticoNews.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 10/6/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import Foundation

extension String {
    func getSubstring(from: String, to: String) -> String? {
        guard let start = range(of: from)?.upperBound, let end = range(of: to, range: start..<endIndex)?.lowerBound else {
            return ""
        }
        
        return String(self[start..<end])
    }
}
