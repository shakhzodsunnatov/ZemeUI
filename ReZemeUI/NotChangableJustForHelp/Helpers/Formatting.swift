//
//  Formatting.swift
//  ZemeCORE
//
//  Created by Benjamin Kushmakov on 10/21/21.
//

import Foundation
import SwiftUI
import Combine

internal func formatAddress() {
    // TODO: Make function do things
}

/// Formats a given currency, as an integer, in USD. Should the given currency
/// string be a nonvalid (negative) integer, or a non-valid currency, return "$0".
/// - Parameter currency: An integer representing a currency amount
/// - Returns: Formatted string in USD
func formatCurrency(currency: Int) -> String {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.maximumFractionDigits = 0
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    
    guard let formatted = formatter.string(from: NSNumber(value: currency)) else {
        return "$0"
    }

    return formatted
}


/// Sanatizes a given currency, in USD, to an integer. Should the given currency
/// string be empty, or a non-valid currency, return 0.
/// - Parameter currency: A currency formatted in USD
/// - Returns: Sanatized integer
func sanatizeCurrency(currency: String) -> Int {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.maximumFractionDigits = 0
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    
    guard let formatted = formatter.number(from: currency) as? Int else {
        return Int(currency.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "$", with: "").replacingOccurrences(of: "%", with: "").replacingOccurrences(of: " ", with: "")) ?? 0
    }
    
    return formatted
}

// 2312421 -> "$2,312,421"
func formatMoney(value: Int) -> String{
    let value = value
    let spaceValue = sanatizeCurrency(currency: String(value))
    return formatCurrency(currency: spaceValue)
}

extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}

func formatPrice(_ n: Int) -> String {
    let num = abs(Double(n))
    let sign = (n < 0) ? "-" : ""

    switch num {
    case 1_000_000_000...:
        var formatted = num / 1_000_000_000
        formatted = formatted.reduceScale(to: 1)
        return "\(sign)\(formatted)B"

    case 1_000_000...:
        var formatted = num / 1_000_000
        formatted = formatted.reduceScale(to: 1)
        return "\(sign)\(formatted)M"

    case 1_000...:
        var formatted = num / 1_000
        formatted = formatted.reduceScale(to: 1)
        return "\(sign)\(formatted)K"

    case 0...:
        return "\(n)"

    default:
        return "\(sign)\(n)"
    }
}


@propertyWrapper
/// A wrapper designed to give a formatted curency for a text-field or other text-based operator,
/// while still allowing for the raw, unformatted value to be accessed for data purposes.
public struct FormattedCurrency: DynamicProperty {
    
    @State var raw_value: String
    
    public init(wrappedValue value: String) {
        self.raw_value = value
    }
    
    public var wrappedValue: String {
        get {
            return formatCurrency(currency: Int(raw_value)!)
        }
        nonmutating set {
            self.raw_value = String(sanatizeCurrency(currency: newValue))
        }
    }
    
    public var projectedValue: Binding<String> {
        Binding(
            get: { return formatCurrency(currency: Int(raw_value)!) },
            set: { self.raw_value = String(sanatizeCurrency(currency: $0)) }
        )
    }
}

// Define number of enum to support auto formating
public enum AutoFormatterType {
    case phone
    case zipcode
    case currency
    
}

// Extension to format and deformat Test
// accepting list symbol(char/string) and it index position in which symbol need to inserted
extension String {
    public func formatString(symbols:[Int:String])->String {
        var formattedComponents = [String]()
        self.forEach {
            if let symbol = symbols[formattedComponents.count] {
                // inserting symbols at its index position to format a text
                formattedComponents.append(symbol)
            }
            if "0123456789".contains($0)
            {
                formattedComponents.append("\($0)")
            }
        }
        return formattedComponents.joined()
    }
    
    public func deformatString()->String {
        return self.filter {
            //removing symbols
            return "0123456789".contains($0)
        }
    }
    
    public var isInt: Bool {
        return Int(self) != nil
    }
    
}

extension Character {
    public var isInt: Bool {
        return Int(String(self)) != nil
    }
}

//creation generic Auto Formatter proporty wrapper
@available(iOS 13.0, *)
@propertyWrapper public struct AutoFormatter : DynamicProperty {
    public var type:AutoFormatterType
    //A Dictionary to hold the list of symbol and its index position
    private var symbolsToInsert = [Int:String]()
    @State private var value = ""
    
    // Here we are doing the magic populating symbol and its index position to symbolsToInsert
    public init(type:AutoFormatterType) {
        self.type = type
        switch type {
        case .phone:
            symbolsToInsert[0] = "("
            symbolsToInsert[4] = ") "
            symbolsToInsert[8] = "-"
        case .zipcode:
            symbolsToInsert[5] = "-"
        case .currency:
            symbolsToInsert[0] = "$"
        }
        
    }
    
    public var wrappedValue: String {
        get {
         value
        }
        nonmutating set {
                value = newValue
        }
    
    }
    public var projectedValue:Binding<String> {
        Binding(get:{
            wrappedValue.formatString(symbols: symbolsToInsert)
        },
        set: {
             wrappedValue = $0.deformatString()
        }
        )

    }
}


//MARK: - Forametting by mask 

func format(with mask: String, phone: String) -> String {
    let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    var result = ""
    var index = numbers.startIndex // numbers iterator

    // iterate over the mask characters until the iterator of numbers ends
    for ch in mask where index < numbers.endIndex {
        if ch == "X" {
            // mask requires a number in this place, so take the next one
            result.append(numbers[index])

            // move numbers iterator to the next index
            index = numbers.index(after: index)

        } else {
            result.append(ch) // just append a mask character
        }
    }
    return result
}
