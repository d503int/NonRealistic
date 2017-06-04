import CoreImage

public class GrayScaleFiler: CustomColorKernelFilter {
    public init?() {
        guard let factory = KernelFactory<CIColorKernel>(fileName: "GrayScale") else {
            return nil
        }
        
        super.init(factory: factory)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("GrayScaleFiler: init(coder:) has not been implemented")
    }
}
