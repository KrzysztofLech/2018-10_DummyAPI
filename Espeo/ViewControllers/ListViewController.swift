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
    @IBOutlet var noDataView: UIView!
    @IBOutlet weak var documentsCounterLabel: UILabel!
    
    
    //MARK: - Properties
    override var prefersHomeIndicatorAutoHidden : Bool { return true }
    private lazy var viewModel: DocumentViewModel = {
        return DocumentViewModel(apiService: APIService())
    }()
    
    
    //MARK: - Life Cycles Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        downloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - Other Methods
    
    private func setupTableView() {
        tableView.register(UINib(nibName: DocumentTableViewCell.toString(), bundle: nil),
                           forCellReuseIdentifier: DocumentTableViewCell.toString())
        tableView.backgroundView = noDataView
    }
    
    private func downloadData() {
        if ReachabilityManager.shared.isReachable() {
            
            viewModel.getDocuments { [weak self] in
                let documentsCount = self?.viewModel.documentsCount ?? 0
                self?.tableView.backgroundView = documentsCount > 0 ? nil : self?.noDataView
                self?.tableView.reloadData()
                self?.documentsCounterLabel.text = String(format: "Documents: %i", documentsCount)
            }
            
        } else {
            
            internetNotAvailableAlert { [weak self] (_) in
                self?.downloadData()
            }
        }
    }
}


//MARK: - TableView Data Source Methods

extension ListViewController: UITableViewDataSource {

    // Sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.documentsCategories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let categoryName = viewModel.documentsCategories[section].name
        let categoryCount = viewModel.documentsCategories[section].items.count
        let headerTitle = String(format: "%@ (%i)", arguments: [categoryName, categoryCount])
        return headerTitle
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.backgroundView?.backgroundColor = UIColor.black
            header.textLabel?.textColor = UIColor.lightGray
            header.textLabel?.textAlignment = .center
            header.textLabel?.numberOfLines = 1
            header.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
        }
    }
    
    // Rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = viewModel.documentsCategories[section].items.count
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DocumentTableViewCell.toString(),
                                                       for: indexPath) as? DocumentTableViewCell else { return UITableViewCell() }
        let document = viewModel.documentsCategories[indexPath.section].items[indexPath.row]
        cell.update(withData: document)
        
        ImageService.downloadImage(withUrl: document.thumbnail) { (image) in
            if cell.thumbnailURL == document.thumbnail {
                cell.activityIndicator.stopAnimating()
                cell.thumbnailImageView.image = image
            }
        }
        
        return cell
    }
}


//MARK: - TableView Delegate Methods

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.toString()) as? DetailViewController else { return }
        vc.document = viewModel.documentsCategories[indexPath.section].items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
