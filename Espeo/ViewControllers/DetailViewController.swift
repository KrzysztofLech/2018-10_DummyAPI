//
//  DetailViewController.swift
//  Espeo
//
//  Created by Krzysztof Lech on 12/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Outlets

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: - Properties
    
    var document: Document!
    private lazy var viewModel: DocumentDetailsViewModel = {
        return DocumentDetailsViewModel(apiService: APIService())
    }()
    
    
    //MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Document details"
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
    //MARK: - Other Methods
    
    private func initViewModel() {
        viewModel.getDocumentDetails(id: document.id) { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}
