//
//  Constants.swift
//  ReZeme
//
//  Created by Shakhzod on 01/03/23.
//

import UIKit


let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height

var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    dateFormatter.dateFormat = "MMM d"
    return dateFormatter
}()

typealias EmptyClosure = ()->Void

extension String {
    var digits: Int {
        return Int(components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()) ?? 0
    }
}
