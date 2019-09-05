//
//  Network.swift
//  TedioffMVC
//
//  Created by Débora Oliveira on 30/08/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

// MARK: - Network

class Network: NSObject {
    
    // MARK: - Variables
    
    typealias NetworkHandler<T> = ((NetworkError?, T?) -> Void)
    static var shared = Network(api: URL(string: "https://www.boredapi.com/api/activity/"))
    var apiUrl: URL?
    
    // MARK: - Initializers
    
    private init(api: URL? = URL(string: "https://www.boredapi.com/api/activity/")) {
        self.apiUrl = api
    }
    
    // MARK: - Class Methods
    
    func requestJSON<T: Decodable>(type: T.Type, completion: @escaping NetworkHandler<T>) {
        guard let url = apiUrl else { completion(.invalidURL, nil); return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
            
            if statusCode != 200 {
                completion(.requestError ,nil)
            }
        
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let parsedData = try decoder.decode(type, from: data)
                completion(nil, parsedData)
            } catch {
                completion(.parseError, nil)
            }
        }.resume()
    }
}
