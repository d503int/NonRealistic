import Foundation
import CoreImage

public class CustomKernelFilter<Kernel: CIKernel, Factory: KernelCreator>: CIFilter where Factory.Kernel == Kernel  {
    
    public var inputImage: CIImage?
    
    let kernel: Kernel
    
    public init?(factory: Factory) {
        guard let kernel = factory.createKernel() else {
            print("CustomKernelFilter: Error: Kernel factory: \(factory) failed to creatre kernel")
            return nil
        }
        
        self.kernel = kernel
        
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("CustomKernelFilter: init(coder:) has not been implemented")
    }
    
    public override var outputImage: CIImage? {
        guard let sourceImage = inputImage else {
            print("CustomKernelFilter: Error: inputImage for filter is nil")
            return nil
        }
        
        return apply(kernel, arguments: [sourceImage], options: nil)
    }
}

public protocol KernelCreator {
    associatedtype Kernel
    
    init?(fileName: String)
    
    func createKernel() -> Kernel?
}

public class KernelFactory<KernelType: CIKernel>: KernelCreator {
    //MARK: Private properties
    private var filePath: String
    
    //MARK: KernelCreator
    public typealias Kernel = KernelType
    
    public required init?(fileName: String) {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "cikernel") else {
            print("CustomKernelFilter: Error: file: \(fileName).cikernel not found in bundle")
            return nil
        }
        
        self.filePath = filePath
    }
    
    public func createKernel() -> KernelType? {
        do {
            let code = try String(contentsOfFile: filePath)
            return KernelType(string: code)
        }
        catch {
            print("CustomKernelFilter: Error: failed to parse file at path: \(filePath) with error: \(error)")
            return nil
        }
    }
}
