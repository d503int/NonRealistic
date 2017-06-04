import Foundation
import CoreImage

public class CustomColorKernelFilter: CustomKernelFilter<CIColorKernel, KernelFactory<CIColorKernel>> {
    public override var outputImage: CIImage? {
        guard let sourceImage = inputImage else {
            print("CustomColorKernelFilter: Error: inputImage for filter is nil")
            return nil
        }
        
        return kernel.apply(withExtent: sourceImage.extent, arguments: [sourceImage])
    }
}
