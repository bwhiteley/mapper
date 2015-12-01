//
//  NSDictionary+Mapper.swift
//  Mapper
//
//  Created by Bart Whiteley on 12/1/15.
//  Copyright © 2015 Lyft. All rights reserved.
//

import Foundation
import Foundation

extension NSDictionary: Mapper {
    public func JSONFromField(field: String) -> AnyObject? {
        return field.isEmpty ? self : self.valueForKeyPath(field)
    }
}
