//
//  PostsDetailViewModel.swift
//  TrycariOS
//
//  Created by Musthafa on 11/05/21.
//

import Foundation
//import RealmSwift
import RxSwift
import RxCocoa

protocol  PostsDetailViewModelProtocol {
    var reloadTableView: (()->())? { get set }
    var post: PostDBModel? { get set }
    func fetchPostComments(post: PostDBModel)
    var items:  Observable <[CommentsDBModel]>? { get set }
    func updateAsFavorite()
}

class PostsDetailViewModel: NSObject, PostsDetailViewModelProtocol {
    var post: PostDBModel?
    
    var reloadTableView: (() -> ())?
    
    var items: Observable<[CommentsDBModel]>?
    func fetchPostComments(post: PostDBModel) {
        self.post = post
        if let comments =  CommentsDBModel.getAllComments(post) {
            items = Observable.just(comments)
        }
        self.reloadTableView?()
    }
    
    func updateAsFavorite() {
        self.post?.updateAsFavorite()
    }
}

