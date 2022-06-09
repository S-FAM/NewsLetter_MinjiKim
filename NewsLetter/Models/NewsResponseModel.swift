//
//  NewsResponseModel.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/08.
//

struct NewsResponseModel: Decodable {
  var articles: [News]
}

struct News: Decodable {
  let source: Source
  let title: String
  let description: String?
  let url: String?
  let urlToImage: String?
  let publishedAt: String
}

struct Source: Decodable {
  let name: String
}
