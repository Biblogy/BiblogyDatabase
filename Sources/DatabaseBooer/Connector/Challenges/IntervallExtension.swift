//
//  File.swift
//  
//
//  Created by Veit Progl on 20.11.22.
//

import Foundation
import CoreData

public enum Intervall: Int16 {
    case day = 0
    case week = 1
    case month = 2
    case year = 3
}

extension ChallengeIntervallPages {
    var intervall: Intervall {
        get {
            guard let newValue = Intervall(rawValue: self.intervallValue) else {
                fatalError("whoops error with Intervall of Challenge")
            }
            return newValue
        }
        set {
            self.intervallValue = newValue.rawValue
        }
    }
}
