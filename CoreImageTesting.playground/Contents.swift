import Foundation
import CoreImage

let lennaImageUrl = Bundle.main.url(forResource: "Lenna", withExtension: "png")!
let test64ImageUrl = Bundle.main.url(forResource: "test64x64", withExtension: "png")!

let context = CIContext()

let lennaImage = CIImage(contentsOf: lennaImageUrl)
let test64Image = CIImage(contentsOf: test64ImageUrl)

// MARK: Sepia filter
let sepiaFilter = CIFilter(name: "CISepiaTone")!

sepiaFilter.setValue(lennaImage, forKey: kCIInputImageKey)
sepiaFilter.setValue(0.5, forKey: kCIInputIntensityKey)

let sepiaResult = sepiaFilter.outputImage

let defaulMonochromeFilter = CIFilter(name: "CIColorMonochrome")!

defaulMonochromeFilter.setValue(lennaImage, forKey: kCIInputImageKey)
let defaultMonochromeColor = CIColor(red: 1.0, green: 1.0, blue: 1.0)
defaulMonochromeFilter.setValue(defaultMonochromeColor, forKey: kCIInputColorKey)
defaulMonochromeFilter.setValue(NSNumber(value: 1.0), forKey: kCIInputIntensityKey)

let defaultMonochromeResult = defaulMonochromeFilter.outputImage

let grayScaleFilter = GrayScaleFiler()!
grayScaleFilter.inputImage = lennaImage
let grayScaleResult = grayScaleFilter.outputImage!

let customMonochromeFilter = ColorMonochromeFilter()!

customMonochromeFilter.setValue(lennaImage, forKey: kCIInputImageKey)
let customMonochromeColor = CIColor(red: 1.0, green: 0.0, blue: 0.0)
customMonochromeFilter.setValue(customMonochromeColor, forKey: kCIInputColorKey)
customMonochromeFilter.setValue(2.0, forKey: kCIInputIntensityKey)

let customMonochromeResult = customMonochromeFilter.outputImage

let extendBorderFilter = ExtendBorderFilter()!

extendBorderFilter.setValue(test64Image, forKey: kCIInputImageKey)
let extendBorderInset = CIVector(x: -10, y: -5)
extendBorderFilter.setValue(extendBorderInset, forKey: "inputInset")

let customExtendedResult = extendBorderFilter.outputImage

//let lanczosScaleTransformFilter = CIFilter(name: "CILanczosScaleTransform")!
//lanczosScaleTransformFilter.setValue(lennaImage, forKey: kCIInputImageKey)
//lanczosScaleTransformFilter.setValue(1.5, forKey: kCIInputScaleKey)
//let lanczosScaleResult = lanczosScaleTransformFilter.outputImage
