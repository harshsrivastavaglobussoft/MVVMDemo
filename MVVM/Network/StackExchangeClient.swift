//
//  StackExchangeClient.swift
//  MVVM
//
//  Created by Sumit Ghosh on 10/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//
//https://api.stackexchange.com/2.2/users/moderators?order=desc&sort=reputation&site=stackoverflow
import Foundation

final class StackExchangeClient {
    
    private lazy var baseURL: URL = {
        return URL.init(string: "http://api.stackexchange.com/2.2/")!
    }()
    
    let  session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchModerators(with request: ModeratorRequest, page: Int, completion:@escaping (Result<PagedModeratorResponse, DataResponseError>) -> Void) {
        
        let urlRequest = URLRequest.init(url: baseURL.appendingPathComponent(request.path))
        
        let parameters = ["page": "\(page)"].merging(request.parameters, uniquingKeysWith: +)
        
        let encodedURLRequest = urlRequest.encode(with: parameters)
        
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.hasSuccessStatusCode,
                let data = data
                else{
                    completion(Result.failure(DataResponseError.network))
                    return
            }
            guard let decodedResponse = try? JSONDecoder().decode(PagedModeratorResponse.self, from: data)else{
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
}
