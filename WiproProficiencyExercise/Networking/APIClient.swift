//
//  APIClient.swift
//  WiproProficiencyExercise
//
//  Created by Kalyan Mannem on 12/12/19.
//  Copyright © 2019 CompIndia. All rights reserved.
//

import Foundation

public enum APIServiceError: Error {
      case apiError
      case invalidEndpoint
      case invalidResponse
      case noData
      case decodeError
}

public class APIClient
{
    var dataTask = URLSessionDataTask()
    
    public func getDataFrom<T:Decodable>(for: T.Type = T.self, url: String,
                                         completion: @escaping (Result<T,APIServiceError>) -> Void)
    {
        print("Service Call")
        guard let url = URL(string: url)
        else
        {
            completion(.failure(.invalidEndpoint))
            return
        }
        URLSession.shared.dataTask(with: url) { (result) in
            switch result
            {
            case .success(let response, let data):
                // Handle Data and Response
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode
                else
                {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do
                {
                    //Facing problem while parsing data for given URL. Need to convert to utf8
                    let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
                    
                    let decoder = JSONDecoder()
                    let canadaData = try decoder.decode(T.self, from: utf8Data!)
                    completion(.success(canadaData))
                }
                catch let error
                {
                    print("\nErr", error.localizedDescription)
                    completion(.failure(.invalidResponse))
                }
                
            case .failure(let error):
                print(error)
                // Handle Error
                completion(.failure(.invalidResponse))
            }
        }.resume()
    }
    
}

extension URLSession
{
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask
    {
        return dataTask(with: url) { (data, response, error) in
            if let error = error
            {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data
            else
            {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
