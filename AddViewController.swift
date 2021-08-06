//
//  AddViewController.swift
//  minutes
//
//  Created by 강성수 on 2021/07/27.
//

import UIKit
//import CoreData

import DropDown
import RealmSwift

class AddViewController: UIViewController {

    // MARK: - 0. 객체 선언
    @IBOutlet var addMinuteTF: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var pickerImage: UIPickerView!
    @IBOutlet weak var dialogueTableView: UITableView!
    @IBOutlet weak var dialogueTF: UITextField!
    @IBOutlet weak var userNameBtn: UIButton!
    
    var minuetDatas = [String]()
    var dates : [Date] = []
    let timeFormatter = DateFormatter()
    
    let MAX_ARRAY_NUM = 9 // 이미지의 파일명을 저장할 배열의 최대 크기를 지정
    let PICKER_VIEW_HEIGHT:CGFloat = 50 // 피커 뷰의 높이 저장
    let PICKER_VIEW_COLUMN = 1 // 피커 뷰의 열의 갯수 지정
    var selectedImageName = "" // 선택된 이미지 이름
    var imageList = ["캉.png", "디아.png", "애런.png","라고.png","영.png","둘리.png","엠마.png","쿠기.png","우노.png"]
    var dropDown = DropDown()
    
    // Realm 데이터 타입 클래스를 선언
    var dataSelected = DialogueData()
    var dialogueSelected = DialogueNames()

    // MARK: - 컨텍스트 변수 & 싱글톤 객체
    // AppDelegate.swift에서 컨텍스트 변수를 활용
    // 싱글톤 객체를 사용
//    let context = (UIApplication.shared.delegate as! AppDelegate),persistentContainer.viewContext
//    let newItem = Item(context: context)
//
//    // 영구 데이터 저장소로 전송
//    func saveItems() {
//
//       do {
//           try context.save()
//
//        } catch {
//           print("Error saving context \(error)")
//        }
//
//        self.tableView.reloadData()
//    }
    
    // MARK: - 2. viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // 뷰가 로드되었을 때 첫번째 이미지 출력
        imageView.image = UIImage(named: imageList[0])
        selectedImageName = imageList[0]
        
        dialogueTableView.delegate = self
        dialogueTableView.dataSource = self
        dialogueTableView.separatorStyle = .none // 테이블 뷰 구분선 없애는 것
        // 사용하려는 셀 등록
//        dialogueTableView.register(UINib(nibName: "MinutesTableViewCell", bundle:nil), forCellReuseIdentifier:"minutesCell")
        // nibName : xib 파일 이름.
        // forCellReuseIdentifier: Cell의 identifier. xib파일안에서 설정가능
        
        dialogueTF.delegate = self
        
        timeFormatter.dateStyle = .medium
        
        // MARK: - Core Data
//        struct Dialogue {
//            var name: String
//            var dialogue: String
//        }
//
//        let rp3 = Dialogue(name: "kang",
//                           dialogue: "안녕하세요")
//
//        // NSManagedObjectContext를 가져온다.
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        // Entity 가져오기
//        let entity = NSEntityDescription.entity(forEntityName: "Minute1", in: context)
//
//        // NSManagedObject를 만든다.
//        if let entity = entity {
//            let dialogues = NSManagedObject(entity: entity, insertInto: context)
//
//            // NSManagedObject에 값을 세팅
//            dialogues.setValue(rp3.name, forKey: "name")
//            dialogues.setValue(rp3.dialogue, forKey: "dialogue")
//
//            // NSManagedObjectContext를 저장
//            do {
//                try context.save()
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//
//        // 현재 저장된걸 불러오기
//        func fetchContact() {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context = appDelegate.persistentContainer.viewContext
//
//            do {
//                let contact = try context.fetch(Minute1.fetchRequest()) as! [Minute1]
//                contact.forEach {
//                    print($0.name ?? "")
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
    }
    
    // MARK: - 3. 발언자명 드롭다운
    @IBAction func userNameDD(_ sender: UIButton) {
        dropDown.dataSource = ["캉", "디아", "애런","라고","영","둘리","엠마","쿠기","우노"]
        dropDown.show()
        dropDown.anchorView = userNameBtn
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            userNameBtn.setTitle(item, for: .normal)
            print(userNameBtn.title(for: .normal) ?? "d")
            self.dropDown.clearSelection()
        }
    }
    
    // MARK: - 발언 저장
    
    @IBAction func saveDialogueBtn(_ sender: UIButton) {
        // 텍스트 필드에 있는 값 minuetDatas array로 보내기
        if dialogueTF.text != "" {
            minuetDatas.append(dialogueTF.text!)
            dialogueTF.text = ""
        }
        
        let lastindexPath = IndexPath(row: minuetDatas.count - 1, section: 0)
        
        dialogueTableView.insertRows(at: [lastindexPath], with: UITableView.RowAnimation.automatic)
        
        // TableView에는 원하는 곳으로 이동하는 함수가 있다. 고로 전송할때마다 최신 대화로 이동.
        dialogueTableView.scrollToRow(at: lastindexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        
        // 버튼 누를 때마다, 현재 날짜 추가
        dates.append(Date())

    }
    
    // MARK: - 4. 새 회의록 추가하기
    @IBAction func addMinuteBtn(_ sender: UIButton) {
        
        itemsImageFile.append(selectedImageName)
        items.append(addMinuteTF.text!)
        
//        dialogueSelected.dialogueNames = addMinuteTF.text!
//        // Realm 가져오기
//        let realm = try! Realm()
//        // Realm에 저장하기
//        try! realm.write {
//            realm.add(dataSelected)
//        }
        
        addMinuteTF.text = ""
    
        dialogueTF.text = ""
        
        _ = navigationController?.popViewController(animated: true)
    }
}

// MARK: - 5. 피커 뷰 델리게이트 설정
extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // 피커 뷰의 컴포넌트 수 설정
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    // 피커 뷰의 높이 설정
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    // 피커 뷰의 개수 설정
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MAX_ARRAY_NUM
    }
    
    // 피커 뷰의 각 ROW의 view 설정
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // print("picker view row : \(row)")
        let imageView = UIImageView(image: UIImage(named: imageList[row]))
        imageView.frame = CGRect(x: 0, y: 0, width: PICKER_VIEW_HEIGHT, height: PICKER_VIEW_HEIGHT)

        return imageView
    }
    
    // 피커 뷰가 선택되었을 때 실행
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        imageView.image = UIImage(named: imageList[row])
        selectedImageName = imageList[row]
    }
    
}

// MARK: - 6. 테이블뷰 & 텍스트필드 델리게이트 설정
extension AddViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return minuetDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    
        let minutesCell = tableView.dequeueReusableCell(withIdentifier: "dialogueCell", for: indexPath) as! MinutesTableViewCell

        minutesCell.dialogue2.text = minuetDatas[indexPath.row]
        minutesCell.name2.text = userNameBtn.title(for: .normal)
//        minutesCell.atTime.text = timeFormatter.string(from: dates[indexPath.row])
        
        // Realm 가져오기
        let realm = try! Realm()
        // Realm에 저장하기
        try! realm.write {
            realm.add(dataSelected)
            // 저장할 realm 객체 지정
            dataSelected.dialogueName = addMinuteTF.text ?? ""
            dataSelected.name = minutesCell.name2.text ?? ""
            dataSelected.dialogueText = minutesCell.dialogue2.text ?? ""

        }
        // 저장한 Realm 불러와 확인하기
        let savedDates = realm.objects(DialogueData.self)
        print(savedDates)
                
        minutesCell.selectionStyle = .none
        
        // 발언 셀 배경색 rgb 랜덤 설정
        let r : CGFloat = CGFloat.random(in: 0.7...1)
        let g : CGFloat = CGFloat.random(in: 0.7...1)
        let b : CGFloat = CGFloat.random(in: 0.7...1)
        minutesCell.contentView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        return minutesCell
    }
}
