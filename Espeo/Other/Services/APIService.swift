//
//  APIService.swift
//  Espeo
//
//  Created by Krzysztof Lech on 12/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation
import Alamofire

struct APIService {
    
    private let documentsUrl = "http://localhost:8080/api/v1/documents"
    
    func getDocuments(closure: @escaping (_ data: [Document]) -> ()) {
        guard let endPointUrl = URL(string: documentsUrl) else {
            print("Error: Cannot create URL")
            return
        }
        
        Alamofire.request(endPointUrl)
            .responseData { (dataResponse) in
                guard let data = dataResponse.data else { return }
                
                let decoder = JSONDecoder()
                do {
                    let apiData = try decoder.decode(Documents.self, from: data)
                    closure(apiData.documents)
                } catch {
                    print("Decode error: ", error)
                }
        }
    }
    
    func getDocumentDetails(id: Int, closure: @escaping (_ data: DocumentDetails) -> ()) {
        let urlString = String(format: "%@/%i", documentsUrl, id)
        guard let endPointUrl = URL(string: urlString) else {
            print("Error: Cannot create URL")
            return
        }
        
        Alamofire.request(endPointUrl)
            .responseData { (dataResponse) in
                guard let data = dataResponse.data else { return }
                
                let decoder = JSONDecoder()
                do {
                    let apiData = try decoder.decode(DocumentDetails.self, from: data)
                    closure(apiData)
                } catch {
                    print("Decode error: ", error)
                }
        }
    }
}
