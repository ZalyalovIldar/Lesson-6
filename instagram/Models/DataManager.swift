import UIKit

class LocalDataManager {
    
    static func getImages(complition: (() -> Void)?) -> [UIImage] {
        
        var images: [UIImage] = []
        for index in 1...6 {
            images.append(UIImage(named: "photo\(index)")!)
        }
        complition?()
        return images
    }
}
