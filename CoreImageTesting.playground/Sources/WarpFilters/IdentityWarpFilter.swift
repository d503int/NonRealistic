import CoreImage

public class IdentityWarpFilter: CustomWarpKernelFilter {
    
    public init?() {
        guard let factory = KernelFactory<CIWarpKernel>(fileName: "IdentityWarp") else {
            return nil
        }
        
        super.init(factory: factory)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("IdentityWarpFilter: init(coder:) has not been implemented")
    }
    
    public override var outputImage: CIImage? {
        guard let sourceImage = inputImage else {
            print("IdentityWarpFilter: Error: inputImage for filter is nil")
            return nil
        }
        
        let roiCallback: CIKernelROICallback = { (_, destRect: CGRect) -> CGRect in
            return CGRect.infinite
        }
        
        let extent: CGRect = sourceImage.extent.insetBy(dx: -10, dy: -10)
        
        let clampedImage = sourceImage.clampingToExtent()
        
        return kernel.apply(withExtent: extent,
                            roiCallback: roiCallback,
                            inputImage: clampedImage,
                            arguments: [])
    }
}
