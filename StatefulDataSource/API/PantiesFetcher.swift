import UIKit

public typealias FetchPantiesHandler = (Result<[Pantie]>) -> Void

func randomBool() -> Bool {
    return arc4random_uniform(2) == 0
}

public class PantiesFetcher {
    
    public static let fetcher = PantiesFetcher()
    
    private func pantiesError() -> NSError {
        return NSError(domain: "com.panties", code: 0, userInfo: nil)
    }
    
    private init() {
        
    }
    
    public func fetchPanties(completion: FetchPantiesHandler) {
        let mustFail = false
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
            
            if mustFail {
                completion(Result.Failure(self.pantiesError()))
            } else {
                let randomPanties = PantiesFetcher.createRandomParties()
                completion(Result.Success(randomPanties))
            }
            
        }
    }
    
    private static func createRandomParties() -> [Pantie] {
        return [
            Pantie(color: .randomColor(), name: NSUUID().UUIDString),
            Pantie(color: .randomColor(), name: NSUUID().UUIDString),
            Pantie(color: .randomColor(), name: NSUUID().UUIDString),
            Pantie(color: .randomColor(), name: NSUUID().UUIDString),
            Pantie(color: .randomColor(), name: NSUUID().UUIDString),
            Pantie(color: .randomColor(), name: NSUUID().UUIDString),
            Pantie(color: .randomColor(), name: NSUUID().UUIDString),
            Pantie(color: .randomColor(), name: NSUUID().UUIDString),
            Pantie(color: .randomColor(), name: NSUUID().UUIDString),
        ]
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
