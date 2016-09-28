//
//  Created by Alejandro Garcia Gil on 28/9/16.
//  Copyright © 2016 SeenJobs. All rights reserved.
//

import Foundation

public protocol ViewModelConfigurable {
    associatedtype VM
    func configureForViewModel(vm: VM)
}

public enum Result<T> {
    case Success(T)
    case Failure(NSError)
}

public enum LoaderState<T> {
    case Loading
    case Loaded(T)
    case Error(NSError)
}
