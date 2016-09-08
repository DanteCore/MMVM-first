//
//  Helper.swift
//  MVVM test
//
//  Created by Serhii Onopriienko on 9/9/16.
//  Copyright © 2016 Edsson. All rights reserved.
//

import Foundation

extension NSDate {
    func dateStringWithFormat(format: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(self)
    }
}