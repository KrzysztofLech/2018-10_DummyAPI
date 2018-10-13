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
    
    var documentsCount: Int {
        return documents.count
    }
    
    var documentsCategories: [DocCategory] = []
    
    
    // MARK: - Init
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    
    // MARK: - Networking
    
    func getDocuments(completion: @escaping Completion) {
        apiService.getDocuments { [weak self] (documents) in
            self?.documents = documents
            print("Downloaded: \(self?.documents.count ?? 0) documents")
            print(documents)
            
            self?.divideDocumentsDataIntoCategories()
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    
    // MARK: - Data Model Methods
    
    private func divideDocumentsDataIntoCategories() {
        documentsCategories.removeAll()
        
        let categoryNames: Set<String> = {
            var set = Set<String>()
            for doc in documents { set.insert(doc.category) }
            return set
        }()
        print(categoryNames)
        
        for categoryName in categoryNames {
            let categoryDocs = documents.filter { $0.category == categoryName }
            let docCategory = DocCategory(name: categoryName, documents: categoryDocs)
            documentsCategories.append(docCategory)
            print(categoryDocs.count, categoryName)
        }
        
        documentsCategories = documentsCategories.sorted { (doc1, doc2) -> Bool in
            return doc1.name < doc2.name
        }
    }
}
