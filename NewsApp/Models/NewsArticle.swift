//
//  NewsArticle.swift
//  NewsApp
//
//  Created by 松島悠人 on 2021/11/10.
//

import Foundation

struct NewsArticlesList: Codable{
    let articles: [NewsArticles]
}

struct NewsArticles: Codable {
    let title: String
    let description: String?
}

extension NewsArticlesList {
    static var all: Resource<NewsArticlesList> =  {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=[API_KEY]")!
        return Resource(url: url)
    }()
}

