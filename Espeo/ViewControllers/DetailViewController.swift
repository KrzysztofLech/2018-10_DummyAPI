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

    @IBOutlet private weak var contentView: UIView!
    
    @IBOutlet private weak var mainActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var imageActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var createdLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    
    
    //MARK: - Properties
    
    override var prefersHomeIndicatorAutoHidden : Bool { return true }
    
    var document: Document!
    private lazy var viewModel: DocumentDetailsViewModel = {
        return DocumentDetailsViewModel(apiService: APIService())
    }()
    
    
    //MARK: - Life Cycles Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        contentView.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadData()
    }

    
    //MARK: - Other Methods
    
    private func downloadData() {
        viewModel.getDocumentDetails(id: document.id) { [weak self] in
            self?.mainActivityIndicator.stopAnimating()
            self?.updateView()
        }
    }
    
    private func updateView() {
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        categoryLabel.text = viewModel.category
        createdLabel.text = viewModel.created
        textLabel.text = viewModel.text.htmlToString
        
        ImageService.downloadImage(withUrl: viewModel.imageURL) { [weak self] (image) in
            self?.imageActivityIndicator.stopAnimating()
            self?.imageView.image = image
        }
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.contentView.alpha = 1.0
        })
    }
}
