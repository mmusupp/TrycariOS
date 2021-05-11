//
//  PostsVC.swift
//  TrycariOS
//
//  Created by Musthafa on 10/05/21.
//

import UIKit
import RxSwift
import RxCocoa


class PostsVC: UIViewController {
    
    lazy var viewModel: PostsViewModelProtocol = PostsViewModel()
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "PostTableCell", bundle: nil), forCellReuseIdentifier: "PostTableCell")
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar(animated: animated)
    }
    
    func initViewModel() {
        
        viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
        viewModel.showError = {
            DispatchQueue.main.async {  }
        }
        viewModel.showLoading = {
            DispatchQueue.main.async {  }
        }
        viewModel.hideLoading = {
            DispatchQueue.main.async { }
        }
        
        viewModel.fetAllPosts()
    }
    
    

}


extension PostsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableCell.self),for: indexPath) as! PostTableCell
        cell.item = self.viewModel.posts?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = StoryboardScene.PostsSB.instantiatePostsDetailVC()
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}
