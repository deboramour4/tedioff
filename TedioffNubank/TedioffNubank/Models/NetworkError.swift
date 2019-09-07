//
//  NetworkError.swift
//  TedioffMVC
//
//  Created by Débora Oliveira on 30/08/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

// MARK: - Network Error

enum NetworkError: Error {
    
    // MARK: - Cases
    
    case invalidURL
    case parseError
    case requestError
}
