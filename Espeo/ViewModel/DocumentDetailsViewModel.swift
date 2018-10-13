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
     var documentDetails: DocumentDetails?
    
    
    // MARK: - Public Properties
    

    // MARK: - Init
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }

    
    // MARK: - Networking
    
    func getDocumentDetails(id: Int, completion: @escaping Completion) {
        apiService.getDocumentDetails(id: id) { [weak self] (documentDetails) in
            self?.documentDetails = documentDetails
            print(documentDetails)
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
}
