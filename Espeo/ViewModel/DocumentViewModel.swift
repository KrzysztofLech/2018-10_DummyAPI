//
//  DocumentViewModel.swift
//  Espeo
//
//  Created by Krzysztof Lech on 12/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

typealias Completion = (()->())

class DocumentViewModel {
    
    // MARK: - Private Properties
    
    private let apiService: APIService
    private var documents: [Document] = []
    
    
    // MARK: - Public Properties
    
    var documentCount: Int {
        return documents.count
    }
    
    
    // MARK: - Init
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    
    // MARK: - Networking
    
    func getDocuments(completion: @escaping Completion) {
        apiService.getDocuments { (documents) in
            self.documents = documents
            DispatchQueue.main.async {
                completion()
                print("Downloaded: \(self.documents.count) documents")
            }
        }
    }

    
}
