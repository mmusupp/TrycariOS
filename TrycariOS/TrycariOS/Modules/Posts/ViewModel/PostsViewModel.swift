//
//  PostsViewModel.swift
//  TrycariOS
//
//  Created by Musthafa on 10/05/21.
//

import Foundation
import RxSwift
import RxCocoa
//import RealmSwift
import Reachability

protocol  PostsViewModelProtocol {
    var reloadTableView: (()->())? { get set }
    var showError: (()->())? { get set }
    func fetchAllPosts()
    func fetchAllComments()
    func retrivedataFromDB()
    var items:  Observable <[PostDBModel]>? { get set }
}

class PostsViewModel: NSObject, PostsViewModelProtocol {
    var items: Observable<[PostDBModel]>?
    
    lazy var webServiceHelper: WebServiceHelperProtocol = WebServiceHelper()    
    var reloadTableView: (() -> ())?
    
    var showError: (() -> ())?
    
    func fetchAllPosts() {
        if (try? (Reachability().connection)) != .unavailable {
            self.reloadTableView?()
            return
        }
        
        webServiceHelper.requestDataFromURL(WebServiceURLs.postsEngPoint, responseClass: [Post].self) { (results, error) in
            if error != nil {
                self.showError?()
                return
            }
            
            if  let resultsPost = results as? [Post] {
                PostDBModel.savePostToDb(results: resultsPost)
                self.reloadTableView?()
                
            }
        }
    }
    
    func retrivedataFromDB()  {
        if let posts = PostDBModel.getAllPost() {
            items =  Observable.just(posts)
        }
    }
    
    func fetchAllComments() {
        
        if (try? (Reachability().connection)) != .unavailable {
            return
        }
        
        webServiceHelper.requestDataFromURL(WebServiceURLs.commentsEngPoint, responseClass: [Comments].self) { (results, error) in
            if error != nil {
                self.showError?()
                return
            }
            if  let resultsPost = results as? [Comments] {
                CommentsDBModel.saveCommentsToDb(results: resultsPost)
            }
        }
    }
    
}
