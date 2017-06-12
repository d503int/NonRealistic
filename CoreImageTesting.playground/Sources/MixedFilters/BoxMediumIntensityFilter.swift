import CoreImage

public class BoxMediumIntensityFilter: CustomKernelFilter<CIKernel, KernelFactory<CIKernel>> {
    
    public var inputBoxSize: CIVector?
    
    public override var attributes: [String : Any] {
        let boxSizeAttributes: [String : Any] = [
            kCIAttributeType : kCIAttributeTypePosition,
            kCIAttributeName: "BoxSize",
            kCIAttributeDefault : BoxMediumIntensityFilter.kDefaultInputBoxSize
        ]
        return ["inputBoxSize" : boxSizeAttributes]
    }
    
    public init?() {
        guard let factory = KernelFactory<CIKernel>(fileName: "BoxMediumIntensity") else {
            return nil
        }
        
        super.init(factory: factory)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("BoxMediumIntensityFilter: init(coder:) has not been implemented")
    }
    
    public override var outputImage: CIImage? {
        guard let sourceImage = inputImage else {
            print("BoxMediumIntensityFilter: Error: inputImage for filter is nil")
            return nil
        }
        
        guard let boxSize = inputBoxSize else {
            print("BoxMediumIntensityFilter: Error: inputBoxSize for filter is nil")
            return nil;
        }
        
        let roiCallback: CIKernelROICallback = { (_, destRect: CGRect) -> CGRect in
            print("BoxMediumIntensityFilter: destRect: \(destRect)")
            return destRect
        }
                
        return kernel.apply(withExtent: sourceImage.extent,
                            roiCallback: roiCallback,
                            arguments: [sourceImage, boxSize])
    }
    
    public override func setDefaults() {
        super.setDefaults()
        
        inputBoxSize = BoxMediumIntensityFilter.kDefaultInputBoxSize
    }
    
    //MARK: Utilty methods
    
    private static var kDefaultInputBoxSize = CIVector(x: 1.0, y: 1.0)
}
