//
//  NewsListTableViewCell.swift
//  NewsApp
//
//  Created by 松島悠人 on 2021/11/10.
//

import UIKit

 class NewsListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    static var className: String {
        return String(describing: self)
    }

    static var idetifier: String {
        return className
    }

    static func nib() -> UINib {
        return UINib(nibName: NewsListTableViewCell.className, bundle: nil)
    }

    func configure(articels: NewsArticles) {
        titleLabel.text = articels.title
        descriptionLabel.text = articels.description
    }
}
