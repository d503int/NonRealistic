import CoreImage

public class IdentityFilter: CustomKernelFilter<CIKernel, KernelFactory<CIKernel>> {
    
    public init?() {
        guard let factory = KernelFactory<CIKernel>(fileName: "Identity") else {
            return nil
        }
        
        super.init(factory: factory)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("IdentityFilter: init(coder:) has not been implemented")
    }
    
    public override var outputImage: CIImage? {
        guard let sourceImage = inputImage else {
            print("IdentityFilter: Error: inputImage for filter is nil")
            return nil
        }
        
        let roiCallback: CIKernelROICallback = { (_, destRect: CGRect) -> CGRect in
            return destRect
        }
        
        let extent: CGRect = sourceImage.extent.insetBy(dx: -10, dy: -10)
        
        let clampedImage = sourceImage.clampingToExtent()
        
        return kernel.apply(withExtent: extent,
                            roiCallback: roiCallback,
                            arguments: [clampedImage])
    }
}
