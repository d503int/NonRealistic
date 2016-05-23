//: Playground - noun: a place where people can play

import CoreImage

let context = CIContext(options: nil)
let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/ru/2/24/Lenna.png")
let image = CIImage(contentsOfURL: url!)


// MARK: Sepia filter
let sepiaFilter = CIFilter(name: "CISepiaTone")
sepiaFilter?.setValue(image, forKey: kCIInputImageKey)
sepiaFilter?.setValue(0.5, forKey: kCIInputIntensityKey)

let result = sepiaFilter?.valueForKey(kCIOutputImageKey)
