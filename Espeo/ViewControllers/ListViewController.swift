//
//  ListViewController.swift
//  Espeo
//
//  Created by Krzysztof Lech on 12/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    private lazy var viewModel: DocumentViewModel = {
        return DocumentViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewModel()
    }
    
    private func initViewModel() {
        viewModel.getDocuments {
            
        }
    }
}
