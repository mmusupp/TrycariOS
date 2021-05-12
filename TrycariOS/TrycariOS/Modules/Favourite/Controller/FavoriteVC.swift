//
//  FavoriteViewController.swift
//  TrycariOS
//
//  Created by Musthafa on 10/05/21.
//

import UIKit
import RxSwift
import RxCocoa
import Reachability

class FavoriteVC: UIViewController {
        
    private let bag = DisposeBag()

    lazy var viewModel: FavoriteVCViewModelProtocol = FavoriteVCViewModel()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "PostTableCell", bundle: nil), forCellReuseIdentifier: "PostTableCell")
            tableView.delegate = self
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initViewModel()
    }
    
    func initViewModel() {
        
        viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.tableView.dataSource = nil
                self.bindRxTable()
                self.tableView.reloadData()
            }
        }
        self.viewModel.fetchFavoritePost()
    }
}

/*extension FavoriteVC: UITableViewDataSource, UITableViewDelegate {

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
}*/


extension FavoriteVC: UITableViewDelegate {
        
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
