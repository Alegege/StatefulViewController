//
//  PantiesInteractor.swift
//  StatefulDataSource
//
//  Created by Alejandro Garcia Gil on 27/9/16.
//  Copyright © 2016 SeenJobs. All rights reserved.
//

import Foundation

public class PantiesInteractor: ProductProvider {

    public static let interactor = PantiesInteractor()
    
    public func provideData(completion: ProductProviderHandler) {
    
        PantiesFetcher.fetcher.fetchPanties { (result) in
            switch result {
            case .Failure(let error):
                completion(.Failure(error))
            case .Success(let panties):
                let pantiesVM = panties.map { ProductViewModel(color: $0.color) }
                completion(.Success(pantiesVM))
            }
        }
    }
}