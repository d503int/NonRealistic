//
//  ScaryBugDoc.swift
//  NPRHalftoning
//
//  Created by d503 on 3/19/16.
//  Copyright © 2016 d503. All rights reserved.
//

import Foundation
import AppKit

class ScaryBugDoc {
    var data: ScaryBugData
    var thumbImage: NSImage?
    var fullImage: NSImage?
    
    init() {
        self.data = ScaryBugData()
    }
    
    init(title: String, rating: Double, thumbImage: NSImage?, fullImage: NSImage?) {
        self.data = ScaryBugData(title: title, rating: rating)
        self.thumbImage = thumbImage
        self.fullImage = fullImage
    }
}