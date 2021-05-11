//
//  FavoriteViewModel.swift
//  TrycariOS
//
//  Created by Musthafa on 11/05/21.
//

import Foundation

protocol  FavoriteVCViewModelProtocol {
    var reloadTableView: (()->())? { get set }
    var posts: [PostDBModel]? { get set }
    func fetchFavoritePost()
}

class FavoriteVCViewModel: NSObject, FavoriteVCViewModelProtocol {
    
    var posts: [PostDBModel]?
    var reloadTableView: (() -> ())?
    var comments: [CommentsDBModel]?
    
    func fetchFavoritePost() {
        if let result = PostDBModel.getAllFavoritePosts() {
            self.posts = result
        }
        self.reloadTableView?()
    }
}
