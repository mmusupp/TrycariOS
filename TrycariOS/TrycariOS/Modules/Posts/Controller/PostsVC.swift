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
    private let bag = DisposeBag()
    lazy var viewModel: PostsViewModelProtocol = PostsViewModel()
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "PostTableCell", bundle: nil), forCellReuseIdentifier: "PostTableCell")
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
                self.bindRxTable()
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
            self.bindRxTable()
        }
       
    }
}


extension PostsVC: UITableViewDelegate {
        
    func bindRxTable() {
        viewModel.items?.bind(to: tableView.rx.items(cellIdentifier: "PostTableCell",
                                                     cellType: PostTableCell.self)) { (_, model: PostDBModel, cell: PostTableCell) in
            cell.item = model
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(PostDBModel.self).subscribe(onNext: { [weak self] item in
                let detailVc = StoryboardScene.PostsSB.instantiatePostsDetailVC()
                detailVc.post = item
                self?.navigationController?.pushViewController(detailVc, animated: true)
            }).disposed(by: bag)
        
    }
}
