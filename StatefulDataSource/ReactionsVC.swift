//
//  Created by Alejandro Garcia Gil on 28/9/16.
//  Copyright © 2016 SeenJobs. All rights reserved.
//

import UIKit

struct ReactionViewModel {
    let reactionEmoji: String = "🙂"
}

public class ReactionsViewController: UIViewController {
    
    let product: ProductViewModel
    
    public init(product: ProductViewModel) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}