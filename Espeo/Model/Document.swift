//
//  Document.swift
//  Espeo
//
//  Created by Krzysztof Lech on 12/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

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
