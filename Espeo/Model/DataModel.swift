//
//  DataModel.swift
//  Espeo
//
//  Created by Krzysztof Lech on 12/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

struct Documents: Decodable {
    let documents: [Document]
}

struct Document: Decodable {
    let id:        Int
    let category:  String
    let title:     String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case category
        case title
        case thumbnail = "thumbnailImg"
    }
}

class DocCategory {
    let name: String
    var items: [Document]
    
    init(name: String, documents: [Document]) {
        self.name = name
        self.items = documents
    }
}

struct DocumentDetails: Decodable {
    let category: String
    let author:   String
    let title:    String
    let text:     String
    let created:  String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case category
        case author
        case title
        case text
        case created
        case imageURL = "headerImg"
    }
}
