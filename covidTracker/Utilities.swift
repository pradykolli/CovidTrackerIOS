//
//  Utilities.swift
//  covidTracker
//
//  Created by pradeep Kolli on 3/27/20.
//  Copyright © 2020 pradeep Kolli. All rights reserved.
//

import Foundation
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int{
    var commaSeparated: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
