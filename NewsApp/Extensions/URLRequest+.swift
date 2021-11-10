//
//  URLRequest+.swift
//  NewsApp
//
//  Created by 松島悠人 on 2021/11/10.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Codable> {
    let url: URL
}

extension URLRequest {
    static func fetch<T>(resource: Resource<T>) -> Observable<T?> {
        return Observable.from([resource.url]).flatMap { url -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
        }.map { data -> T? in
            return try? JSONDecoder().decode(T.self, from: data)
        }.asObservable()
    }
}
