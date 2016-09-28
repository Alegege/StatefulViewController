//
//  Created by Alejandro Garcia Gil on 28/9/16.
//  Copyright © 2016 SeenJobs. All rights reserved.
//

import UIKit

public class StatefulCollectionViewDataSource<VM, Cell:ViewModelConfigurable where Cell:UICollectionViewCell, Cell.VM == VM>: NSObject, UICollectionViewDataSource {
    
    private let reuseID = "FuckMe"
    weak var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.registerClass(Cell.self, forCellWithReuseIdentifier: reuseID)
        collectionView.dataSource = self
    }
    
    public var state: LoaderState<[VM]> = .Loading {
        didSet {
            switch state {
            case .Loading:
                collectionView?.reloadData()
            case .Loaded:
                collectionView?.reloadData()
            case .Error:
                collectionView?.reloadData()
            }
        }
    }

    //MARK:- UICollectionViewDataSource
    
    @objc public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .Loaded(let models):
            return models.count
        default:
            return 0
        }
    }
    
    @objc public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch state {
        case .Loaded(let models):
            let model = models[indexPath.row]
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseID, forIndexPath: indexPath) as! Cell
            cell.configureForViewModel(model)
            return cell
        default:
            fatalError()
        }
    }
}
