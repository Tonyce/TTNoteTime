//
//  Note+CoreDataProperties.swift
//  NoteTime
//
//  Created by D_ttang on 15/12/29.
//  Copyright © 2015年 D_ttang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Note {

    @NSManaged var time: NSDate?
    @NSManaged var text: String?
    @NSManaged var colorIndex: NSNumber?

}
