//
//  NewsArticleViewModel.swift
//  NewsApp
//
//  Created by 松島悠人 on 2021/11/10.
//

import Foundation
import RxSwift
import RxCocoa


struct NewsArticleListViewModel {
    let aritclesVM: [NewsArticleViewModel]
}

extension NewsArticleListViewModel {

    init(_ articles: [NewsArticles]) {
        self.aritclesVM = articles.compactMap(NewsArticleViewModel.init)
    }
}

extension NewsArticleListViewModel {

    func articleAt(_ index: Int) -> NewsArticleViewModel {
        return self.aritclesVM[index]
    }
}

struct NewsArticleViewModel {
    let article: NewsArticles

    init(_ article: NewsArticles) {
        self.article = article
    }
}

extension NewsArticleViewModel {
    var title: Observable<String> {
        return Observable.just(article.title)
    }

    var description: Observable<String> {
        return Observable.just(article.description ?? "")
    }
}
