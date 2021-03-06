//
//  DocumentTableViewCell.swift
//  Espeo
//
//  Created by Krzysztof Lech on 12/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var thumbnailURL: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
    
    private func resetCell() {
        thumbnailImageView.image = nil
        titleLabel.text = nil
        activityIndicator.startAnimating()
    }
    
    func update(withData document: Document) {
        titleLabel.text = document.title
        thumbnailURL = document.thumbnail
    }
}
