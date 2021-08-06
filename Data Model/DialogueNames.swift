//
//  DialogueNames.swift
//  minutes
//
//  Created by 강성수 on 2021/07/29.
//

import Foundation
import RealmSwift

class DialogueNames: Object {
    @objc dynamic var dialogueNames : String = ""
    
    var dialogues = List<DialogueData>()
    
    var hasDialogues: Bool {
        return dialogues.count > 0
    }
    
    // 기본키 설정
    override class func primaryKey() -> String? {
        return "dialogueNames"
    }
    
    // 재정의하여 인덱스에 추가 속성을 설정.
    override class func indexedProperties() -> [String] {
        return ["dialogueNames"]
    }
    
}
