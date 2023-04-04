//
//  Prefecture+LogoURL.swift
//  
//
//  Created by 史 翔新 on 2023/03/28.
//

import Foundation
import FakeFortuneTelling

extension Prefecture {
    
    private var kunreiSpell: String {
        switch self {
        case .gunma:
            return "gumma"
            
        default:
            return "\(self)"
        }
    }
    
    var logoURL: URL {
        
        return .init(string: "https://japan-map.com/wp-content/uploads/\(kunreiSpell).png") ?? {
            assertionFailure("Invalid prefecture spell: \(kunreiSpell)")
            return NSURL(fileURLWithPath: "") as URL
        }()
        
    }
    
}
