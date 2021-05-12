//
//  PostModel.swift
//  TrycariOS
//
//  Created by Musthafa on 10/05/21.
//

import Foundation



struct Post : Codable {
    let id : Int?
    let title : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
    
    init(id: Int,title: String) {
        self.id = id
        self.title = title
    }
}
