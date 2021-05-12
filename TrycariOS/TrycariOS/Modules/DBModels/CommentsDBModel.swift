//
//  Comments.swift
//  TrycariOS
//
//  Created by Musthafa on 11/05/21.
//

import RealmSwift

class CommentsDBModel: Object {
    
    @objc dynamic var body: String = ""
    @objc dynamic var id = 0
    @objc dynamic var postId = 0
    
    convenience init(id: Int, body: String, postId: Int) {
        self.init()
        self.id = id
        self.body = body
        self.postId = postId
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func saveCommentsToDb(results: [Comments])  {
        var arrayOfComents = [CommentsDBModel]()
        for comment in results {
            if let id = comment.id, let postID = comment.postId, let body = comment.body {
                arrayOfComents.append(CommentsDBModel(id: id, body: body, postId: postID))
            }
        }
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(arrayOfComents, update: .modified)
        }
    }
    
    
    static func getAllComments(_ post: PostDBModel) -> [CommentsDBModel]? {
        do {
            let realm = try Realm()
            let comments = realm.objects(CommentsDBModel.self).filter("postId == %i", post.id)
            return Array(comments) 
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}
