//
//  Comments.swift
//  TrycariOS
//
//  Created by Musthafa on 11/05/21.
//

import Foundation

struct Comments : Codable {
    let id : Int?
    let postId : Int?
    let body : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case body = "body"
        case postId = "postId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        postId = try values.decodeIfPresent(Int.self, forKey: .postId)
        body = try values.decodeIfPresent(String.self, forKey: .body)
    }
    
    init(id: Int,body: String, postId: Int) {
        self.id = id
        self.body = body
        self.postId = postId
    }
}
