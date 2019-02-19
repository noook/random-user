//
//  StringExtension.swift
//  random-user
//
//  Created by Neil Richter on 22/01/2019.
//  Copyright © 2019 Neil Richter. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
