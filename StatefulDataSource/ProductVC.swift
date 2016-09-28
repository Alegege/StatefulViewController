import UIKit

public struct ProductViewModel {
    let color: UIColor
}

public typealias ProductProviderHandler = (Result<[ProductViewModel]>) -> Void

public protocol ProductProvider {
    func provideData(completion: ProductProviderHandler)
}

public class ProductViewController: UIViewController {
    
    let provider: ProductProvider
    
    public init(provider: ProductProvider) {
        self.provider = provider
        self.dataSource = StatefulCollectionViewDataSource(collectionView: collectionView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
        
    //MARK: - Stored properties
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let dataSource: StatefulCollectionViewDataSource<ProductViewModel, ProductCell>
    
    //MARK: - UIViewController lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        setup()
        fetchData()
    }
    
    //MARK: - Private API
    private func layout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        collectionView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        collectionView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        collectionView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        activityIndicator.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    }
    
    private func setup() {
        view.backgroundColor = UIColor.whiteColor()
        
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(ProductCell.self, forCellWithReuseIdentifier: String(ProductViewController))
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        activityIndicator.hidesWhenStopped = true
    }
    
    private func fetchData() {
        self.dataSource.state = .Loading
        self.provider.provideData { result in
            switch result {
            case .Failure(let error):
                self.dataSource.state = .Error(error)
            case .Success(let products):
                self.dataSource.state = .Loaded(products)
            }
        }
    }

    private func presentError(error: NSError) {
        let alertController = UIAlertController(title: "Error", message: "The product's warehouse has burnt! ⚠️", preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "Retry", style: .Default) { _ in
            self.fetchData()
        }
        alertController.addAction(alertAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}


extension ProductViewController: UICollectionViewDelegate {
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch dataSource.state {
        case .Loaded(let products):
            let product = products[indexPath.row]
            let reactionsVC = ReactionsViewController(product: product)
            self.navigationController?.pushViewController(reactionsVC, animated: true)
        default:
            fatalError()
        }
    }
}

struct Donkey {}

class DonkeyCell: UICollectionViewCell, ViewModelConfigurable {
    func configureForViewModel(vm: Donkey) {

    }
}

class ProductCell: UICollectionViewCell, ViewModelConfigurable {
    func configureForViewModel(vm: ProductViewModel) {
        contentView.backgroundColor = vm.color
    }
}
