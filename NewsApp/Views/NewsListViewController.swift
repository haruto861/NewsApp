//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by 松島悠人 on 2021/11/09.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

final class NewsListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(NewsListTableViewCell.nib(), forCellReuseIdentifier: NewsListTableViewCell.idetifier)
        }
    }
    private let disposeBag = DisposeBag()
    private var articels = [NewsArticles]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        fetchNewsArticels()
    }

    private func fetchNewsArticels() {
        URLRequest.fetch(resource: NewsArticlesList.all)
            .subscribe(onNext: { [weak self] res in
                if let results = res {
                    self?.articels = results.articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
    }
}

extension NewsListViewController: UITableViewDelegate {

}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.idetifier, for: indexPath) as! NewsListTableViewCell
        cell.configure(articels: self.articels[indexPath.row])
        return cell
    }
}
