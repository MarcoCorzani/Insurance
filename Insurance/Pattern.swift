//
//  Pattern.swift
//  Insurance
//
//  Created by Marco F.A. Corzani on 24.11.14.
//  Copyright (c) 2014 Alphaweb. All rights reserved.
//

import Foundation
import CoreData

class Pattern: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var frontImage: NSData
    @NSManaged var backImage: NSData

}
