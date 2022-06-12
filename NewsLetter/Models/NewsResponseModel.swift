//
//  NewsResponseModel.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/08.
//

struct NewsResponseModel: Decodable {
  var items: [News] = []
}

struct News: Decodable {
  let title: String
  let link: String
  let description: String
  let pubDate: String
}
