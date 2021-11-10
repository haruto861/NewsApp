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
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=[API_KEY]") else { return }

        Observable.just(url).flatMap { url -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
        }.map { data -> [NewsArticles]? in
            return try? JSONDecoder().decode(NewsArticlesList.self, from: data).articles
        }.subscribe(onNext: { articles in
            if let articles = articles {
                self.articels = articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
