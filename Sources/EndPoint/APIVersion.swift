//
//  APIVersion.swift
//  
//
//  Created by 史 翔新 on 2022/12/15.
//

import Foundation
import Compute

enum APIVersion {
    
    enum InitializationError: Error {
        case invalidVersionString(String)
    }
    
    case v1
        
    init?(versionString: String?) throws {
        
        guard let versionString else {
            return nil
        }
        
        switch versionString {
        case "v1":
            self = .v1
            
        case let invalid:
            throw InitializationError.invalidVersionString(invalid)
        }
        
    }
}
