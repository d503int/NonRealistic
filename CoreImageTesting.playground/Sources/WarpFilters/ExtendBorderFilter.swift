import CoreImage

public class ExtendBorderFilter: CustomWarpKernelFilter {
    
    public var inputInset: CIVector?
    
    public override var attributes: [String : Any] {
        
        let inputInsetAttributes: [String : Any] = [
            kCIAttributeType : kCIAttributeTypeOffset,
            kCIAttributeName: "Inset",
            kCIAttributeDefault : ExtendBorderFilter.kDefaultInputInset
        ]
        
        print("ExtendBorderFilter.attributes");
        
        return [
            "inputInset" : inputInsetAttributes
        ]
    }
    
    public init?() {
        guard let factory = KernelFactory<CIWarpKernel>(fileName: "ExtendBorder") else {
            return nil
        }
        
        super.init(factory: factory)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("ExtendBorderFilter: init(coder:) has not been implemented")
    }
    
    public override var outputImage: CIImage? {
        guard let sourceImage = inputImage else {
            print("ExtendBorderFilter: Error: inputImage for filter is nil")
            return nil
        }
        
        guard let inset = inputInset else {
            print("ExtendBorderFilter: Error: inputInset for filter is nil")
            return nil
        }
        
        let roiCallback: CIKernelROICallback = { (_, destRect: CGRect) -> CGRect in
            return destRect
        }
        
        let center = CIVector(x: sourceImage.extent.midX, y: sourceImage.extent.midY);
        
        let extent = sourceImage.extent.insetBy(dx: inset.x, dy: inset.y)
        
        return kernel.apply(withExtent: extent,
                            roiCallback: roiCallback,
                            inputImage: sourceImage,
                            arguments: [center])
    }
    
    public override func setDefaults() {
        super.setDefaults()
        
        inputInset = ExtendBorderFilter.kDefaultInputInset
    }
    
    //MARK: Utilty methods
    
    private static var kDefaultInputInset = CIVector(x: 0, y: 0)
}
