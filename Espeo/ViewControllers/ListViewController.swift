//
//  ListViewController.swift
//  Espeo
//
//  Created by Krzysztof Lech on 12/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var documentsCounterLabel: UILabel!
    
    
    //MARK: - Properties
    
    private lazy var viewModel: DocumentViewModel = {
        return DocumentViewModel(apiService: APIService())
    }()
    
    
    //MARK: - Life Cycles Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewModel()
        
        tableView.register(UINib(nibName: DocumentTableViewCell.toString(), bundle: nil),
                           forCellReuseIdentifier: DocumentTableViewCell.toString())
    }
    
    
    //MARK: - Other Methods
    
    private func initViewModel() {
        viewModel.getDocuments { [weak self] in
            self?.tableView.reloadData()
            self?.documentsCounterLabel.text = String(format: "Documents: %i", self?.viewModel.documentsCount ?? 0)
        }
    }
}


//MARK: - TableView Data Source Methods

extension ListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.documentsCategories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let categoryName = viewModel.documentsCategories[section].name
        let categoryCount = viewModel.documentsCategories[section].items.count
        let headerTitle = String(format: "%@ (%i)", arguments: [categoryName, categoryCount])
        return headerTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = viewModel.documentsCategories[section].items.count
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DocumentTableViewCell.toString(),
                                                       for: indexPath) as? DocumentTableViewCell else { return UITableViewCell() }
        let document = viewModel.documentsCategories[indexPath.section].items[indexPath.row]
        cell.titleLabel.text = document.title
        return cell
    }
}


//MARK: - TableView Delegate Methods

extension ListViewController: UITableViewDelegate {
    
}
