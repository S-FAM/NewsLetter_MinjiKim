//
//  NewsSearchManager.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/08.
//

import Alamofire
import Foundation

protocol NewsSearchManagerProtocol {
  func request(
    from keyword: String,
    start: Int,
    display: Int,
    completionHandler: @escaping ([News]) -> Void
  )
}

struct NewsSearchManager: NewsSearchManagerProtocol {
  func request(
    from keyword: String,
    start: Int,
    display: Int,
    completionHandler: @escaping ([News]) -> Void
  ) {
    guard let url = URL(string: "https://openapi.naver.com/v1/search/news.json") else { return }

    let parameters = NewsRequestModel(start: start, display: display, query: keyword)
    let headers: HTTPHeaders = [
      "X-Naver-Client-Id": NewsAPIKey.id,
      "X-Naver-Client-Secret": NewsAPIKey.secret
    ]

    AF
      .request(url, method: .get, parameters: parameters, headers: headers)
      .responseDecodable(of: NewsResponseModel.self) { response in
        switch response.result {
        case .success(let result):
          completionHandler(result.items)
          print(result)
        case .failure(let error):
          print(error)
        }
      }
      .resume()
  }
}
