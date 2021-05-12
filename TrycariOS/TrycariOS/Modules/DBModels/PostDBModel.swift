//
//  Post.swift
//  TrycariOS
//
//  Created by Musthafa on 11/05/21.
//

import RealmSwift

class PostDBModel: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var id = 0
    @objc dynamic var favorite = false
    @objc dynamic var shouldSync = false
    
    convenience init(id: Int, title: String, favorite: Bool = false, shouldSync: Bool = false) {
        self.init()
        self.id = id
        self.title = title
        self.favorite = favorite
        self.shouldSync = shouldSync
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }

    static func savePostToDb(results: [Post])  {
        var arrayOfPosts = [PostDBModel]()
        for post in results {
            if let id = post.id, let post = post.title {
                arrayOfPosts.append(PostDBModel(id: id, title: post))
            }
        }
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(arrayOfPosts, update: .modified)
        }
    }
    
    static func getAllPost() -> [PostDBModel]? {
        do {
            let realm = try Realm()
            let posts = realm.objects(PostDBModel.self)
            return Array(posts)
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    
    func updateAsFavorite() {
        do {
            let realm = try Realm()
            let posts = realm.objects(PostDBModel.self).filter("id == \(self.id)")
            if let post = posts.first {
                try! realm.write {
                    post.favorite = true
                }
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    static func getAllFavoritePosts() -> [PostDBModel]? {
        do {
            let realm = try Realm()
            let posts = realm.objects(PostDBModel.self).filter("favorite = \(true)")
            return Array(posts)
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    
    static func getunSyncData() -> [PostDBModel]? {
        do {
            let realm = try Realm()
            let posts = realm.objects(PostDBModel.self).filter("shouldSync = \(true)")
            return Array(posts)
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }

}


