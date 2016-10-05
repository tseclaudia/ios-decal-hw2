//
//  BaseExtension.swift
//  SwiftCalc
//
//  Created by Zach Zeleznick on 9/21/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    struct Number {
        static var formatter = NumberFormatter()
    }
    var scientificStyle: String {
        Number.formatter.numberStyle = .scientific
        Number.formatter.positiveFormat = "0.##E0"
        Number.formatter.exponentSymbol = "e"
        let val =  NSDecimalNumber(decimal: Decimal(self))
        return Number.formatter.string(from: val) ?? description
    }
    
    // TODO: Make the string human readable!
    var prettyOutput: String {
        /* SPECS:
            1. Returns a max of 7 characters (including any decimal point / negative sign).
            2. Do not include any leading zeros or trailing zeros.
            3. Display an integer when the result is an integer of allowable size.
            Optional: Use scientific notation for any values that exceed the character max.
        */
        

        //      Remove leading zeros
        var result = String(self)
        while (String(result.characters.prefix(1)) == "0" &&
            result[result.index(result.startIndex, offsetBy: 1)] != "." &&
            result != "0") {
                result = String(result.characters.dropFirst())
        }
        //      Remove trailing zeros
        while (result[result.index(before: result.endIndex)] == "0" &&
            result[result.index(result.startIndex, offsetBy: result.characters.count-2)] != ".") {
                result = String(result.characters.dropLast())
        }
        if (String(result.characters.suffix(2)) == ".0") {
            result = String(result.characters.dropLast(2))
        }
        
        //      Returns a max of 7 characters
        if (result.characters.count > 7) {
            result = String(result.characters.prefix(7))
        }
        
        return result
    }
}

// MARK: Enables Colors from Hex Codes
extension UIColor{
    convenience init(rgb: UInt, alphaVal: CGFloat? = 1.0) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alphaVal!)
        )
    }
}


