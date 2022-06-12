//
//  NewsSearchManager.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/08.
//

import Alamofire
import Foundation

protocol NewsSearchManagerProtocol {
  func getTopHeadlines(
    pageSize: Int,
    page: Int,
    completionHandler: @escaping ([News]) -> Void
  )
}

struct NewsSearchManager: NewsSearchManagerProtocol {
  func getTopHeadlines(
    pageSize: Int,
    page: Int,
    completionHandler: @escaping ([News]) -> Void
  ) {
    guard let url = URL(string: "https://newsapi.org/v2/top-headlines") else { return }

    let parameters = NewsRequestModel(
      apiKey: NewsAPIKey.key,
      country: "kr",
      pageSize: pageSize,
      page: page
    )

    AF
      .request(url, method: .get, parameters: parameters)
      .responseDecodable(of: NewsResponseModel.self) { response in
        switch response.result {
        case .success(let result):
          completionHandler(result.articles)
//          print(result)
        case .failure(let error):
          print(error)
        }
      }
      .resume()
  }
}
