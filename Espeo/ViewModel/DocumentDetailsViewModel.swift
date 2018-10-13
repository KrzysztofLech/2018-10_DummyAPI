//
//  DocumentDetailsViewModel.swift
//  Espeo
//
//  Created by Krzysztof Lech on 13/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

class DocumentDetailsViewModel {
    
    // MARK: - Private Properties
    
    private let apiService: APIService
    private var documentDetails: DocumentDetails?
    
    
    // MARK: - Public Properties
    
    var imageURL: String {
        return documentDetails?.imageURL ?? ""
    }
    
    var title: String {
        return documentDetails?.title ?? ""
    }
    
    var author: String {
        return documentDetails?.author ?? ""
    }
    
    var category: String {
        return documentDetails?.category ?? ""
    }
    
    var created: String {
        // 2018-10-12T13:49:24.119590
        let documentCreated = documentDetails?.created ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        if let date = dateFormatter.date(from: documentCreated) {
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        }
        return " "
    }
    
    var text: String {
        return documentDetails?.text ?? ""
    }

    // MARK: - Init
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }

    
    // MARK: - Networking
    
    func getDocumentDetails(id: Int, completion: @escaping Completion) {
        apiService.getDocumentDetails(id: id) { [weak self] (documentDetails) in
            self?.documentDetails = documentDetails
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
