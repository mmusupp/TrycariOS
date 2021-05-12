//
//  FavoriteViewModel.swift
//  TrycariOS
//
//  Created by Musthafa on 11/05/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol  FavoriteVCViewModelProtocol {
    
    var reloadTableView: (()->())? { get set }
    
    var items: Observable<[PostDBModel]>? { get set }
    
    func fetchFavoritePost()
}

class FavoriteVCViewModel: NSObject, FavoriteVCViewModelProtocol {
    
    var items: Observable<[PostDBModel]>?

    var reloadTableView: (() -> ())?
        
    func fetchFavoritePost() {
        if let results = PostDBModel.getAllFavoritePosts() {
            items = Observable.just(results)
        }
        self.reloadTableView?()
    }
}
