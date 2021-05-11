//
//  PostsVC.swift
//  TrycariOS
//
//  Created by Musthafa on 10/05/21.
//

import UIKit
import RxSwift
import RxCocoa
import Reachability

class PostsVC: UIViewController {
    
    lazy var viewModel: PostsViewModelProtocol = PostsViewModel()
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "PostTableCell", bundle: nil), forCellReuseIdentifier: "PostTableCell")
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
        
    func initViewModel() {
        
        viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.viewModel.retrivedataFromDB()
                self.tableView.reloadData()
            }
        }
        
        viewModel.showError = {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.viewModel.retrivedataFromDB()
                self.tableView.reloadData()
            }
        }
        
        if (try? (Reachability().connection)) != .unavailable {
            viewModel.fetchAllPosts()
            viewModel.fetchAllComments()
        } else {
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.viewModel.retrivedataFromDB()
            self.tableView.reloadData()
        }
       
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
        detailVc.post = self.viewModel.posts?[indexPath.row]
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}
