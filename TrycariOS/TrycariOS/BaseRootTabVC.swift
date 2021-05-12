//
//  ViewController.swift
//  TrycariOS
//
//  Created by Musthafa on 10/05/21.
//

import UIKit

class BaseRootTabVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [self.getPostsVC(), self.getFavoriteVC() ]
    }
}

extension BaseRootTabVC {
    
    func getPostsVC() -> UIViewController {
        let postsVC = StoryboardScene.PostsSB.instantiatePostsVC()
        let title = "Posts"
        let tabBarItem = UITabBarItem(title:title,
                                           image: UIImage(named: "book")?.imageFlippedForRightToLeftLayoutDirection(),
                                           selectedImage: UIImage(named: "book")?.imageFlippedForRightToLeftLayoutDirection())
        postsVC.tabBarItem = tabBarItem
        let nvc = UINavigationController(rootViewController: postsVC)
        return nvc
    }
    
  
    func getFavoriteVC() -> UIViewController {
        let favoriteVC = StoryboardScene.FavoritesSB.instantiateFavoritesVC()
        let title = "Favourite"
        
        let tabBarItem = UITabBarItem(title:title,
                                           image: UIImage(named: "shop")?.imageFlippedForRightToLeftLayoutDirection(),
                                           selectedImage: UIImage(named: "shop")?.imageFlippedForRightToLeftLayoutDirection())
        favoriteVC.tabBarItem = tabBarItem
        let nvc = UINavigationController(rootViewController: favoriteVC)
        return nvc
    }
    
}
