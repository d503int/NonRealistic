import CoreImage

public class ExtendBorderFilter: CustomWarpKernelFilter {
    
    public var inputSymmetricalInsets: CIVector?
    
    public var inputTopInset: NSNumber?
    public var inputBottomInset: NSNumber?
    public var inputLeftInset: NSNumber?
    public var inputRightInset: NSNumber?

    public override var attributes: [String : Any] {
        
        let symmetricalInsetsAttributes: [String : Any] = [
            kCIAttributeType : kCIAttributeTypeOffset,
            kCIAttributeName: "SymmetricalInsets",
            kCIAttributeDefault : ExtendBorderFilter.kDefaultInputSymmetricalInsets
        ]
        
        let edgeInsetAttributes: [String : Any] = [
            kCIAttributeType : kCIAttributeTypeScalar,
            kCIAttributeName: "EdgeInset",
            kCIAttributeDefault : ExtendBorderFilter.kDefaultInputEdgeInset
        ]
        
        return [
            "inputSymmetricalInsets" : symmetricalInsetsAttributes,
            "inputTopInset" : edgeInsetAttributes,
            "inputBottomInset" : edgeInsetAttributes,
            "inputLeftInset" : edgeInsetAttributes,
            "inputRightInset" : edgeInsetAttributes
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
        
        var extent: CGRect = sourceImage.extent
        
        if let inset = inputSymmetricalInsets {
            extent = sourceImage.extent.insetBy(dx: inset.x, dy: inset.y)
        }
        else if let insetTop = inputTopInset?.floatValue,
            let insetBottom = inputBottomInset?.floatValue,
            let insetLeft = inputLeftInset?.floatValue,
            let insetRight = inputRightInset?.floatValue {
            extent.origin.x -= CGFloat(insetLeft)
            extent.origin.y -= CGFloat(insetBottom)
            extent.size.width += CGFloat(insetLeft + insetRight)
            extent.size.height += CGFloat(insetTop + insetBottom)
        }
        else {
            print("ExtendBorderFilter: Error: inputSymmetricalInsets and inputEdgeInsets for filter are nil")
            return nil
        }
        
        let roiCallback: CIKernelROICallback = { (_, destRect: CGRect) -> CGRect in
            return destRect
        }
        
        let size = CIVector(x: sourceImage.extent.size.width, y: sourceImage.extent.size.height)
        
        return kernel.apply(withExtent: extent,
                            roiCallback: roiCallback,
                            inputImage: sourceImage,
                            arguments: [size])
    }
    
    public override func setDefaults() {
        super.setDefaults()
        
        inputSymmetricalInsets = ExtendBorderFilter.kDefaultInputSymmetricalInsets
        inputTopInset = ExtendBorderFilter.kDefaultInputEdgeInset
        inputBottomInset = ExtendBorderFilter.kDefaultInputEdgeInset
        inputLeftInset = ExtendBorderFilter.kDefaultInputEdgeInset
        inputRightInset = ExtendBorderFilter.kDefaultInputEdgeInset
    }
    
    //MARK: Utilty methods
    
    private static var kDefaultInputSymmetricalInsets = CIVector(x: 0.0, y: 0.0)
    private static var kDefaultInputEdgeInset = NSNumber(value: 0.0)

}
