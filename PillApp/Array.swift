//
//  Array.swift
//  PillApp
//
//  Created by Bruno Scheltzke on 06/10/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation

extension Array {
    func toData() -> Data? {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}
