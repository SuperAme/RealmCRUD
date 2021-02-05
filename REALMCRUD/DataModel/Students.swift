//
//  Students.swift
//  REALMCRUD
//
//  Created by IDS Comercial on 2/5/21.
//  Copyright © 2021 Américo MQ. All rights reserved.
//

import Foundation
import RealmSwift

class Students: Object {
    @objc dynamic var name: String?
    @objc dynamic var subject: String?
    @objc dynamic var score: String?
}
