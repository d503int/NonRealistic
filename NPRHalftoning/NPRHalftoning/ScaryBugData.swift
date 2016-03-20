//
//  ScaryBugData.swift
//  NPRHalftoning
//
//  Created by d503 on 3/19/16.
//  Copyright © 2016 d503. All rights reserved.
//

import Foundation

class ScaryBugData {
    var title: String
    var rating: Double
    
    init() {
        self.title = String()
        self.rating = 0.0
    }
    
    init(title: String, rating: Double) {
        self.title = title
        self.rating = rating
    }
}