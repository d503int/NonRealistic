import Foundation
import CoreImage

public class IdentityColorFilter: CustomColorKernelFilter {
    
    public init?() {
        guard let factory = KernelFactory<CIColorKernel>(fileName: "IdentityColor") else {
            return nil
        }
        
        super.init(factory: factory)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("IdentityColorFilter: init(coder:) has not been implemented")
    }
    
    public override var outputImage: CIImage? {
        guard let sourceImage = inputImage else {
            print("IdentityColorFilter: Error: inputImage for filter is nil")
            return nil
        }
        
        let extent: CGRect = sourceImage.extent.insetBy(dx: -10, dy: -10)
        
        let clampedImage = sourceImage.clampingToExtent()

        return kernel.apply(withExtent: extent, arguments: [clampedImage])
    }
}

