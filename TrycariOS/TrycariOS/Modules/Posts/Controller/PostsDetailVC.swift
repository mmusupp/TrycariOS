//
//  PostsDetailVC.swift
//  TrycariOS
//
//  Created by Musthafa on 11/05/21.
//

import UIKit

class PostsDetailVC: UIViewController {

    var post: PostDBModel?
    @IBOutlet weak var lblPostTitle: UILabel!
    @IBOutlet weak var lblCommentsTitle: UILabel!
    lazy var viewModel: PostsDetailViewModelProtocol = PostsDetailViewModel()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "CommentsCell", bundle: nil), forCellReuseIdentifier: "CommentsCell")
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblPostTitle.text = post?.title ?? ""
        self.initViewModel()
    }
    
    func initViewModel() {
        
        viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.lblCommentsTitle.text = (self.viewModel.comments?.count ?? 0) > 0 ? "Comments" : ""
                self.tableView.reloadData()
                
            }
        }
        
        viewModel.fetchPostComments(post: post!)
    }
    
   
    @IBAction func buttonOneTouched(_ sender: Any) {
        viewModel.updateAsFavorite()
    }
}

extension PostsDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: String(describing: CommentsCell.self),for: indexPath) as! CommentsCell
        cell.item = self.viewModel.comments?[indexPath.row]
        return cell
    }
    

}
