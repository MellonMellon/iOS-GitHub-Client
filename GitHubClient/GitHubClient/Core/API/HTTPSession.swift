//
//  HTTPSession.swift
//  nouslibertin
//
//  Created by favre on 14/01/2018.
//  Copyright © 2018 cbk-interactive. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
  case options = "OPTIONS"
  case get     = "GET"
  case head    = "HEAD"
  case post    = "POST"
  case put     = "PUT"
  case patch   = "PATCH"
  case delete  = "DELETE"
  case trace   = "TRACE"
  case connect = "CONNECT"
}

enum HTTPError: Error {
  case unknownError
  case connectionError
  case invalidCredentials
  case invalidRequest
  case notFound
  case invalidResponse
  case serverError
  case serverUnavailable
  case timeOut
  case unsuppotedURL
}

public protocol UrlConvertible {
  var baseUrl: String { get }
  var version: String { get }
  var endPoint: String { get }
  var parameters:[String: Any] { get }
  var headers: [String: String] { get }
  var method: HTTPMethod { get }
}

extension UrlConvertible {
  
  var baseUrl: String {
    return "https://api.github.com"
  }
  
  func asUrl() -> URL? {
    return URL(string:"\(self.baseUrl)\(self.version)\(self.endPoint)")
  }
}

class MockedSession: URLSession {
  
  override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    var task = URLSessionDataTask()

    
    return task
  }
}

struct HTTPSession {
  
  public static func request(urlConvertible: UrlConvertible, completion: @escaping (Data?, Error?) -> Void) {
    guard let url = urlConvertible.asUrl()
      else { return }
    
    var request: URLRequest = URLRequest(url: url)
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    
    request.httpMethod = urlConvertible.method.rawValue
    
    for header in urlConvertible.headers {
      request.addValue(header.value, forHTTPHeaderField: header.key)
    }
    
    if let jsonData = try? JSONSerialization.data(withJSONObject: urlConvertible.parameters), urlConvertible.parameters.count > 0 {
      
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.httpBody = jsonData
    }
    
    print("[🚀] (\(urlConvertible.method.rawValue))\(url.absoluteString)")
    
    let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
      if let httpResponse = response as? HTTPURLResponse {
        print("[\(httpResponse.statusCode != 200 ? "💔" : "💚")] status code : \(httpResponse.statusCode)")
        switch httpResponse.statusCode {
        case 404: completion(nil, HTTPError.notFound); return
        case 400: completion(nil, HTTPError.invalidRequest); return
        case 401: completion(nil, HTTPError.invalidCredentials); return
        case 500: completion(nil, HTTPError.unknownError); return
        default:()
        }
      }
      
      if let error = error {
        completion(nil, error)
      } else {

        if let data = data, let str = String(data: data, encoding: String.Encoding.utf8) {
         print(str)
        }
        
        completion(data, nil)
      }
    })
    task.resume()
  }
}

