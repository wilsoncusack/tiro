//
//  Fetch.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String)

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}

// change this from being a publisher

//func fetch(url: URL, method: String, parameters: [[String: Any]]) -> AnyPublisher<Data, APIError> {
//    print("making fetch request")
//    var request = URLRequest(url: url)
//    request.httpMethod = method
//    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
//        request.httpBody = jsonData
//
//    return URLSession.DataTaskPublisher(request: request, session: .shared)
//        .tryMap { data, response in
//            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
//                throw APIError.unknown
//            }
//            return data
//        }
//        .mapError { error in
//            if let error = error as? APIError {
//                return error
//            } else {
//                return APIError.apiError(reason: error.localizedDescription)
//            }
//        }
//        .eraseToAnyPublisher()
//}

func fetch(url: URL, body: Data?){
    
    var request = URLRequest(url:url)
    request.httpMethod = "POST"
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.httpBody = body
    
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data,
            let response = response as? HTTPURLResponse,
            error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
        }
        
        guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
            print("statusCode should be 2xx, but is \(response.statusCode)")
            print("response = \(response)")
            return
        }
        
        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(String(describing: responseString?.debugDescription))")
    }
    
    task.resume()
}


func networkLog(sessionLog: [Log]){
//    guard let url = URL(string: "https://tiro-api-live.herokuapp.com/logs") else { return }
    guard let url = URL(string: "http://localhost:8080/logs") else { return }
    let parameters = sessionLog.map {log in
           [
               "event":log.action,
               "timestamp":log.time.timeIntervalSince1970,
               "anonymousUserID":log.anonID.description
               
           ]
        }
    let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
    fetch(url: url, body: jsonData)
}

func logSingle(log: Log){
//    guard let url = URL(string: "https://tiro-api-live.herokuapp.com/log") else { return }
    guard let url = URL(string: "http://localhost:8080/log") else { return }
    let parameters : [String: Any] =
           [
               "event":log.action,
               "timestamp":log.time.timeIntervalSince1970,
               "anonymousUserID":log.anonID.description
               
           ]
    let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
    fetch(url: url, body: jsonData)
}
