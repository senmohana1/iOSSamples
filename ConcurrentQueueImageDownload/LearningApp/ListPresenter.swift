
import Foundation
typealias imageLoadInfo = (isToReload: Bool, image: Data)

class ListPresenter {
    let imagePath = "https://homepages.cae.wisc.edu/~ece533/images/"
    var imageCache = NSCache<NSURL, NSData>()
    init() {
    }
    func loadData(imageName: String, completion: @escaping(imageLoadInfo) -> Void) {
        getImages(imageName: imageName) { imageInfo in
            completion(imageLoadInfo(imageInfo.isToReload,imageInfo.image))
        }
    }
    private func getImages(imageName: String, completion:@escaping(imageLoadInfo) -> Void) {
        let concurrentQueue = DispatchQueue(label: "concurrent", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        concurrentQueue.async {
            do {
                if let data =  self.imageCache.object(forKey: URL(string: (self.imagePath + imageName))! as NSURL) {
                    completion(imageLoadInfo(isToReload: false, image: data as Data))
                } else {
                    let data =  try? Data(contentsOf: URL(string: (self.imagePath + imageName))!)
                    if let data = data {
                        self.imageCache.setObject(data as NSData, forKey: URL(string: (self.imagePath + imageName))! as NSURL)
                        completion(imageLoadInfo(isToReload: true, image: data as Data))
                    }
                }
            }
        }
    }
    
}
