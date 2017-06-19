import Foundation
import CoreImage

public class ColorMonochromeFilter: CustomColorKernelFilter {
    
    public var inputColor: CIColor?
    public var inputIntensity: NSNumber?

    public override var attributes: [String : Any] {
        return [
            kCIInputColorKey : [kCIAttributeDefault : ColorMonochromeFilter.kDefaultInputColor],
            kCIInputIntensityKey : [kCIAttributeDefault : ColorMonochromeFilter.kDefaultInputIntensity]
        ]
    }
    
    public init?() {
        guard let factory = KernelFactory<CIColorKernel>(fileName: "ColorMonochrome") else {
            return nil
        }
        
        super.init(factory: factory)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("ColorMonochromeFilter: init(coder:) has not been implemented")
    }
    
    public override var outputImage: CIImage? {
        guard let sourceImage = inputImage else {
            print("ColorMonochromeFilter: Error: inputImage for filter is nil")
            return nil
        }
        
        guard let color = inputColor else {
            print("ColorMonochromeFilter: Error: inputColor for filter is nil")
            return nil
        }
        
        guard let intensity = inputIntensity else {
            print("ColorMonochromeFilter: Error: inputIntensity for filter is nil")
            return nil
        }
        
        return kernel.apply(withExtent: sourceImage.extent, arguments: [sourceImage, color, intensity])
    }
    
    public override func setDefaults() {
        super.setDefaults()
        
        inputColor = ColorMonochromeFilter.kDefaultInputColor
        inputIntensity = ColorMonochromeFilter.kDefaultInputIntensity
        
        print("ColorMonochromeFilter.setDefaults()")
    }
    
    //MARK: Utilty methods
    
    private static var kDefaultInputColor = CIColor(cgColor: CGColor.white)
    private static var kDefaultInputIntensity = NSNumber(value: 1.0)
}
