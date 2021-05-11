//
//  StoryboardScene.swift
//  TrycariOS
//
//  Created by Musthafa on 10/05/21.
//


import UIKit

protocol StoryboardSceneType {
    static var storyboardName: String { get }
}

extension StoryboardSceneType {
    
    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }
    
    static func initialViewController() -> UIViewController {
        guard let vc = storyboard().instantiateInitialViewController() else {
            fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
        }
        return vc
    }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
    
    func viewController() -> UIViewController {
        return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
    }
    static func viewController(identifier: Self) -> UIViewController {
        return identifier.viewController()
    }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
    func performSegue<S: StoryboardSegueType>(segue: S, sender: AnyObject? = nil) where S.RawValue == String {
        performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}

struct StoryboardScene {
}

// MARK:  Post Storyboard
extension StoryboardScene {
    
    enum PostsSB: String, StoryboardSceneType {
        
        static let storyboardName = "PostsSB"
        
        case postsVCScene  = "PostsVC"
        
        static func instantiatePostsVC() -> PostsVC {
            guard let vc = StoryboardScene.PostsSB.postsVCScene.viewController() as? PostsVC else {
                fatalError("ViewController 'PostsVC' is not of the expected class PostsVC.")
            }
            return vc
        }
        
        case postsDetailVCScene  = "PostsDetailVC"
        static func instantiatePostsDetailVC() -> PostsDetailVC {
            guard let vc = StoryboardScene.PostsSB.postsDetailVCScene.viewController() as? PostsDetailVC else {
                fatalError("ViewController 'PostsDetailVC' is not of the expected class PostsVC.")
            }
            return vc
        }
    }
}


// MARK:  Post Favorites
extension StoryboardScene {
    
    enum FavoritesSB: String, StoryboardSceneType {
        
        static let storyboardName = "FavouriteSB"
        
        case favoritesVCScene  = "FavoriteVC"
        
        static func instantiateFavoritesVC() -> FavoriteVC {
            guard let vc = StoryboardScene.FavoritesSB.favoritesVCScene.viewController() as? FavoriteVC else {
                fatalError("ViewController 'FavoriteVC' is not of the expected class FavoriteVC.")
            }
            return vc
        }
    }
}


