import Foundation
import CoreImage

public class CustomWarpKernelFilter: CustomKernelFilter<CIWarpKernel, KernelFactory<CIWarpKernel>> {
    public override var outputImage: CIImage? {
        guard let sourceImage = inputImage else {
            print("CustomWarpKernelFilter: Error: inputImage for filter is nil")
            return nil
        }
        
        let roiCallback: CIKernelROICallback = { (_, destRect: CGRect) -> CGRect in
            return CGRect.null
        }
        
        return kernel.apply(withExtent: sourceImage.extent,
                            roiCallback: roiCallback,
                            inputImage: sourceImage,
                            arguments: [sourceImage])
    }
}
