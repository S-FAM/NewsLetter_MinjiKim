//
//  String+.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/12.
//

import Foundation

extension String {
  /// Remove html tag in String
  var htmlToString: String {
    guard let data = data(using: .utf8) else { return "" }

    do {
      return try NSAttributedString(
        data: data,
        options: [
          .documentType: NSAttributedString.DocumentType.html,
          .characterEncoding: String.Encoding.utf8.rawValue
        ],
        documentAttributes: nil
      ).string
    } catch {
      return ""
    }
  }
}
