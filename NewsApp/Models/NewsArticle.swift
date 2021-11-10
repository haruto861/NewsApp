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
    let description: String
}
