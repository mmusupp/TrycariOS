//
//  PostsViewModel.swift
//  TrycariOS
//
//  Created by Musthafa on 10/05/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol  PostsViewModelProtocol {
    var reloadTableView: (()->())? { get set }
    var showError: (()->())? { get set }
    var showLoading: (()->())? { get set }
    var hideLoading: (()->())? { get set }
    var posts: [Post]? { get set }
    func fetAllPosts()
}

class PostsViewModel: NSObject, PostsViewModelProtocol {
    
    lazy var webServiceHelper: WebServiceHelperProtocol = WebServiceHelper()

    var posts: [Post]?
    
    var reloadTableView: (() -> ())?
    
    var showError: (() -> ())?
    
    var showLoading: (() -> ())?
    
    var hideLoading: (() -> ())?
    
    
    func fetAllPosts() {
        webServiceHelper.requestDataFromURL(WebServiceURLs.postsEngPoint, responseClass: [Post].self) { (results, error) in
            if error != nil {
                self.showError?()
                return
            }
            if (results as? [Post]) != nil {
                self.posts = results as? [Post]
                self.reloadTableView?()
            }
            
        }
    }
}
