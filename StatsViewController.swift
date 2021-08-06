//
//  StatsViewController.swift
//  minutes
//
//  Created by 강성수 on 2021/07/28.
//

import UIKit
import RealmSwift

class StatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // realm 파일 위치 출력
//        print(Realm.Configuration.defaultConfiguration.fileURL!)

        // MARK: - 필터링
//        let realm = try! Realm()
//        let savedDatas = realm.objects(DialogueData.self)
//        // 이름 (카운팅) 기준으로 정렬
//        print(savedDatas.sorted(byKeyPath: "name", ascending: true))
    }
    
    // MARK: - 데이터 삭제
//    override func delete(_ sender: Any?) {
//        let realm = try! Realm()
//        let dataSelected = DialogueData()
//        dataSelected.name = name
//        dataSelected.dialoguetext = text
//
//        //삭제하는 방법
//        do{
//            try realm.write{
//                let predicate = NSPredicate(format: "year = %@ AND month = %@ AND day = %@", year, month, day)
//                realm.delete(realm.objects(DateRealm.self).filter(predicate))
//            }
//        } catch{ print("\(error)") }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
