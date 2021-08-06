//
//  DetailViewController.swift
//  minutes
//
//  Created by 강성수 on 2021/07/27.
//

import UIKit
import RealmSwift

// MARK: - 회의록명 수정 프로토콜 선언
protocol EditDelegate {
    func didMessageEditDone(_ controller: DetailViewController, message: String)
}

class DetailViewController: UIViewController {

    // MARK: - 변수 선언
    var receiveItem : String = ""
    var receivedMinute : String = ""
    var sendItem : String = ""
    var delegate : EditDelegate?
    
    // Realm 데이터 타입 클래스를 선언
    var dataSelectedDetail = DialogueData()
    var dialogueSelectedDetail = DialogueNames()
    
    @IBOutlet var minuteName: UILabel!
    @IBOutlet var editMinuteNameTF: UITextField!
    @IBOutlet weak var minuteDetailTableView: UITableView!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        minuteDetailTableView.delegate = self
        minuteDetailTableView.dataSource = self
        minuteDetailTableView.separatorStyle = .none // 테이블 뷰 구분선 없애는 것
        
        minuteName.text = receiveItem
        
        editMinuteNameTF.text = sendItem
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - 리스트 리로딩
    // 뷰가 노출될 때마다 리스트의 데이터를 다시 불러옴
    override func viewWillAppear(_ animated: Bool) {
        minuteDetailTableView.reloadData()
    }
    
    // MARK: - 메인화면으로 수정된 회의록명 보내기
    @IBAction func editMinuteNameBtn(_ sender: UIButton) {
        
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: editMinuteNameTF.text!)
        }
        
        // 메인 화면으로 이동하기
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 메인화면에서 회의록명를 받아오기 위한 함수
    func receiveItem(_ item: String){
        receiveItem = item
    }
    
    // MARK: - 추가화면에서 회의록을 받아오기 위한 함수
    func receiveMinute(_ minute: String){
        receivedMinute = minute
        
        // MARK: - 필터링
//        let realm = try! Realm()
//        let savedDatas = realm.objects(DialogueData.self)
//        // 이름 (카운팅) 기준으로 정렬
//        print(savedDatas.sorted(byKeyPath: "dialogueName", ascending: true))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // if minuteName.text == DialogueData.dialogueName -> DialogueData.dialogueText 열의 개수
        
        return dataSelectedDetail.dialogueText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Realm 가져오기
//        let realm = try! Realm()
//        let titles = realm.objects(DialogueNames.self)
//        
//        // 기본키 사용
//        let title = realm.object(ofType: DialogueNames.self, forPrimaryKey: minuteName.text)
//        
//        // 필터
//        realm.objects(DialogueNames.self).filter("dialogueName == '\(minuteName.text)'")
        
        let minuteDetailCell = tableView.dequeueReusableCell(withIdentifier: "minuteDetailCell", for: indexPath) as! MinuteDetailTableViewCell

        minuteDetailCell.detailName.text = [dataSelectedDetail.name][(indexPath as NSIndexPath).row] // [indexPath.row]
        
        minuteDetailCell.detailDialogue.text = [dataSelectedDetail.dialogueText][(indexPath as NSIndexPath).row]
        
        minuteDetailCell.selectionStyle = .none
        
        // 발언 셀 배경색 rgb 랜덤 설정
        let r : CGFloat = CGFloat.random(in: 0.7...1)
        let g : CGFloat = CGFloat.random(in: 0.7...1)
        let b : CGFloat = CGFloat.random(in: 0.7...1)
        minuteDetailCell.contentView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        return minuteDetailCell
    }
    
    // 목록 삭제 함수
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: (indexPath as NSIndexPath).row)
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // 삭제 시 "Delete" 대신 "삭제"로 표시
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    // 목록 순서 바꾸기
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = items[(fromIndexPath as NSIndexPath).row]
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]
        items.remove(at: (fromIndexPath as NSIndexPath).row)
        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)
        items.insert(itemToMove, at: (to as NSIndexPath).row)
        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row)
    }
    
}
