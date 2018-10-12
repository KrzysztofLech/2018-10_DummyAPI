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
        return DocumentViewModel()
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
        viewModel.getDocuments {
            
        }
    }
}


//MARK: - TableView Data Source Methods

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DocumentTableViewCell.toString(),
                                                       for: indexPath) as? DocumentTableViewCell else { return UITableViewCell() }
        
        // konfigurujemy celkę
        
        return cell
    }
    
    
}


//MARK: - TableView Delegate Methods

extension ListViewController: UITableViewDelegate {
    
}
