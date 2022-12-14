//
//  VersionPath.swift
//  
//
//  Created by 史 翔新 on 2022/12/15.
//

import Foundation
import Compute

enum VersionInPath {
    
    enum InitializationError: Error {
        case invalidVersionString(String)
    }
    
    case v1
    
    static let versionPathID = "version"
    
    init?(request: IncomingRequest) throws {
        
        guard let versionString = request.pathParams[Self.versionPathID] else {
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
