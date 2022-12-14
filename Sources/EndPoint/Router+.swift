//
//  Router+.swift
//  
//
//  Created by 史 翔新 on 2022/12/15.
//

import Compute

extension Router {
    
    @discardableResult
    public func get(_ path: String, mayAppendingAfterParameter prefixID: String, _ handler: @escaping Handler) -> Self {
        
        self.get(":\(prefixID)/\(path)", handler)
            .get(path, handler)
        
    }
}
