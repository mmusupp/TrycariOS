//
//  PostsVCTests.swift
//  TrycariOSTests
//
//  Created by Musthafa on 12/05/21.
//

import XCTest
import RxSwift
import RxCocoa

@testable import TrycariOS

class PostsVCTests: XCTestCase {
    
    var vc: PostsVC!
    
    private func setUpViewControllers() {
        self.vc = StoryboardScene.PostsSB.instantiatePostsVC()
        vc.viewModel = MockPostsViewModel()
        self.vc.loadView()
        self.vc.viewDidLoad()
    }
    
    override func setUp() {
        super.setUp()
        self.setUpViewControllers()
    }
    
    override func tearDown() {
        self.vc.tableView.dataSource = nil
        self.vc = nil
    }
    
    
    func testViewDidLoad_shouldLoadView() {
        XCTAssertNotNil(self.vc, "view VC is nil")
        XCTAssertNotNil(self.vc.tableView, "tableview is nil")
    }
    
    func testInitViewModel_ShouldInitializeViewModel() {
//        vc.initViewModel()
        XCTAssertNotNil(self.vc.viewModel.reloadTableView, "view VC is nil")
        XCTAssertNotNil(self.vc.viewModel.showError, "view VC is nil")
    }
    
    func testfetchAllPosts_ShouldshouldGetAllpostLoadTableVIew() {
        self.vc.viewModel.retrivedataFromDB()
        self.vc.bindRxTable()
        self.vc.tableView.reloadData()
        XCTAssertEqual(self.vc.tableView.numberOfSections, 1, "Number of section should be equal 1")
        XCTAssertEqual(self.vc.tableView.numberOfRows(inSection: 0), 5, "Number of section should be equal 1")
        
        let cell_1 = self.vc.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell_1!.isKind(of: PostTableCell.self), "Should be PostTableCell")
        XCTAssertEqual((cell_1 as? PostTableCell)?.postTitle.text, "postDBModel_1")
        
        let cell_2 = self.vc.tableView.cellForRow(at: IndexPath(row: 1, section: 0))
        XCTAssertTrue(cell_2!.isKind(of: PostTableCell.self), "Should be PostTableCell")
        
        let cell_3 = self.vc.tableView.cellForRow(at: IndexPath(row: 2, section: 0))
        XCTAssertTrue(cell_3!.isKind(of: PostTableCell.self), "Should be PostTableCell")
        
        let cell_4 = self.vc.tableView.cellForRow(at: IndexPath(row: 3, section: 0))
        XCTAssertTrue(cell_4!.isKind(of: PostTableCell.self), "Should be PostTableCell")
        
        let cell_5 = self.vc.tableView.cellForRow(at: IndexPath(row: 4, section: 0))
        XCTAssertTrue(cell_5!.isKind(of: PostTableCell.self), "Should be PostTableCell")
    }
}

class MockPostsViewModel: PostsViewModelProtocol {
    
    var items: Observable<[PostDBModel]>?

    
    func fetchAllPosts() {
        self.reloadTableView?()
    }
    func fetchAllComments() {
        
    }
    func retrivedataFromDB() {
        let postDBModel_1 = PostDBModel(id: 1, title: "postDBModel_1", favorite: false, shouldSync: false)
        let postDBModel_2 = PostDBModel(id: 1, title: "postDBModel_2", favorite: false, shouldSync: false)
        let postDBModel_3 = PostDBModel(id: 1, title: "postDBModel_3", favorite: false, shouldSync: false)
        let postDBModel_4 = PostDBModel(id: 1, title: "postDBModel_4", favorite: false, shouldSync: false)
        let postDBModel_5 = PostDBModel(id: 1, title: "postDBModel_5", favorite: false, shouldSync: false)
        self.items =  Observable.just([postDBModel_1,postDBModel_2,postDBModel_3, postDBModel_4,postDBModel_5])
    }
    
    var reloadTableView: (()->())?
    var showError: (()->())?
    
    
}
