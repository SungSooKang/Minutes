//
//  Data.swift
//  minutes
//
//  Created by 강성수 on 2021/07/29.
//

import Foundation
import RealmSwift

class DialogueData: Object {
//    var minuetDatas = [String]()
    @objc dynamic var name : String = ""
    @objc dynamic var dialogueText : String = ""
    @objc dynamic var dialogueName : String = ""
    
    var parentDialogueName = LinkingObjects(fromType: DialogueNames.self, property: "dialogues")
    
//    override class func primaryKey() -> String? {
//        return "dialogueName"
//    }
//
//    override class func indexedProperties() -> [String] {
//        return ["dialogueName", "name","dialogueText"]
//    }
    
}
