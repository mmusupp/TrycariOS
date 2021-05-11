//
//  PostsDetailViewModel.swift
//  TrycariOS
//
//  Created by Musthafa on 11/05/21.
//

import Foundation
import RealmSwift

protocol  PostsDetailViewModelProtocol {
    var reloadTableView: (()->())? { get set }
    var post: PostDBModel? { get set }
    func fetchPostComments(post: PostDBModel)
    var comments: [CommentsDBModel]? { get set }
    
    func updateAsFavorite()
}

class PostsDetailViewModel: NSObject, PostsDetailViewModelProtocol {
    var post: PostDBModel?
    
    var reloadTableView: (() -> ())?
    
    var comments: [CommentsDBModel]?
    
    func fetchPostComments(post: PostDBModel) {
        self.post = post
        comments =  CommentsDBModel.getAllComments(post)
        self.reloadTableView?()
    }
    
    func updateAsFavorite() {
        self.post?.updateasFavorite()
    }
}

