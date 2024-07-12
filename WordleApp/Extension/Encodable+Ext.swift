//
//  Encodable+Ext.swift
//  WordleApp
//
//  Created by Jaideep Singh on 11/07/24.
//

import Foundation


extension Encodable {
  func encodeJSON() throws -> Data {
    try JSONEncoder().encode(self)
  }
}

extension Encodable {
  subscript(key: String) -> Any? {
    return dictionary[key]
  }
  var dictionary: [String: Any] {
    let decoder = JSONDecoder()
    return (try? decoder.decode([String : String].self,
                  from: encodeJSON())) ?? [:]
  }
}

extension URLRequest {
 public var curlString: String {
  var result = "curl -k "
  if let method = httpMethod {
   result += "-X \(method) \\\n"
  }
  if let headers = allHTTPHeaderFields {
   for (header, value) in headers {
    result += "-H \"\(header): \(value)\" \\\n"
   }
  }
  if let body = httpBody, !body.isEmpty, let string = String(data: body, encoding: .utf8), !string.isEmpty {
   result += "-d '\(string)' \\\n"
  }
  if let url = url {
   result += url.absoluteString
  }
  return result
 }
}
