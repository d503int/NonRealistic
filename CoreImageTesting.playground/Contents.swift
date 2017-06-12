import Foundation
import CoreImage

let lennaImageUrl = Bundle.main.url(forResource: "Lenna", withExtension: "png")!
let test64ImageUrl = Bundle.main.url(forResource: "test64x64", withExtension: "png")!
let test64Border1ImageUrl = Bundle.main.url(forResource: "test64x64Border1", withExtension: "png")!
let test64Border2ImageUrl = Bundle.main.url(forResource: "test64x64Border2", withExtension: "png")!
let context = CIContext()

let lennaImage = CIImage(contentsOf: lennaImageUrl)
let test64Image = CIImage(contentsOf: test64ImageUrl)
let test64Border1Image = CIImage(contentsOf: test64Border1ImageUrl)
let test64Border2Image = CIImage(contentsOf: test64Border2ImageUrl)

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

extendBorderFilter.setValue(lennaImage , forKey: kCIInputImageKey)
//let extendSymmetricalInsets = CIVector(x: -10, y: -10)
//extendBorderFilter.setValue(extendSymmetricalInsets, forKey: "inputSymmetricalInsets")
extendBorderFilter.setValue(NSNumber(value: 5.0), forKey: "inputTopInset")
extendBorderFilter.setValue(NSNumber(value: 5.0), forKey: "inputBottomInset")
extendBorderFilter.setValue(NSNumber(value: 5.0), forKey: "inputLeftInset")
extendBorderFilter.setValue(NSNumber(value: 5.0), forKey: "inputRightInset")

let customExtendedResult = extendBorderFilter.outputImage

//let lanczosScaleTransformFilter = CIFilter(name: "CILanczosScaleTransform")!
//lanczosScaleTransformFilter.setValue(lennaImage, forKey: kCIInputImageKey)
//lanczosScaleTransformFilter.setValue(1.5, forKey: kCIInputScaleKey)
//let lanczosScaleResult = lanczosScaleTransformFilter.outputImage


let boxMediumIntensityFilter = BoxMediumIntensityFilter()!
boxMediumIntensityFilter.setDefaults()  

boxMediumIntensityFilter.setValue(lennaImage , forKey: kCIInputImageKey)
//boxMediumIntensityFilter.setValue(CIVector(x: 5.0, y: 5.0), forKey: "inputBoxSize")

let boxMediumIntensityResult = boxMediumIntensityFilter.outputImage

