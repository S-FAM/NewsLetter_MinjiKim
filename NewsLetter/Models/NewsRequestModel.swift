//
//  NewsRequestModel.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/08.
//

import Foundation

struct NewsRequestModel: Codable {
  let start: Int
  let display: Int
  let query: String
}
