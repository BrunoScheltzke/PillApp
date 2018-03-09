//
//  FrequencyTableViewCellDelegate.swift
//  PillApp
//
//  Created by Eduardo Fornari on 09/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation

protocol FrequencyTableViewCellDelegate {
    func update(day: Frequency, check: Bool)
}
