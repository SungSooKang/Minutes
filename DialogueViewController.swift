//
//  DialogueViewController.swift
//  minutes
//
//  Created by 강성수 on 2021/07/27.
//

import UIKit

class DialogueViewController: UIViewController {

    @IBOutlet weak var minutesTableView: UITableView!
    
    var minutesDatas = [String]()
    
    @IBOutlet weak var inputMinuteText: UITextView! {
        didSet {
            inputMinuteText.delegate = self
        }
    }
    @IBOutlet weak var inputMinuteTextHeight: NSLayoutConstraint!
    @IBOutlet weak var inputMinuteTextBottomMargin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        minutesTableView.delegate = self
        minutesTableView.dataSource = self
        
        // 테이블 뷰 구분선 없애는 것
//        minutesTableView.separatorStyle = .none
        
        // MARK: - 1. 사용하려는 셀 등록
        minutesTableView.register(UINib(nibName: "MinutesTableViewCell", bundle:nil), forCellReuseIdentifier:"minutesCell")
        // nibName : xib 파일 이름
        // forCellReuseIdentifier: Cell의 identifier. xib파일안에서 설정가능
        
        // MARK: - 2. 키보드 관련 옵저버 설정
        // 키보드 올라올 때.
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardup), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // 키보드 내려올 때.
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDown), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyBoardup(noti: Notification){
        let notiInfo = noti.userInfo!
        let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        // 홈 버튼 없는 아이폰들은 다 빼줘야함.
        let height = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
        
        let animationDuration = notiInfo[ UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        // 키보드 올라오는 애니메이션이랑 동일하게 텍스트뷰 올라가게 만들기.
        UIView.animate(withDuration: animationDuration) {
            self.inputMinuteTextBottomMargin.constant = height
            self.view.layoutIfNeeded()
        }
    }
        
    @objc func keyBoardDown(noti: Notification){
        
        let notiInfo = noti.userInfo!
        let animationDuration = notiInfo[ UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            self.inputMinuteTextBottomMargin.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func addMinuteButton(_ sender: UIButton) {
        if inputMinuteText.text != "" {
            minutesDatas.append(inputMinuteText.text)
            inputMinuteText.text = ""
        }
        
        let lastIndexPath = IndexPath(row: minutesDatas.count - 1, section: 0)
        
        // 리로드
        minutesTableView.insertRows(at: [lastIndexPath], with: UITableView.RowAnimation.automatic)
        
        // 높이 제한
//        inputMinuteTextHeight.constant = 35
        
        // TableView에는 원하는 곳으로 이동하는 함수가 있다. 고로 전송할때마다 최신 대화로 이동.
        minutesTableView.scrollToRow(at: lastIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
    }
    
}

extension DialogueViewController: UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return minutesDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let minutesCell = tableView.dequeueReusableCell(withIdentifier: "minutesCell", for: indexPath) as! MinutesTableViewCell
        minutesCell.dialogue.text = minutesDatas[indexPath.row]
        minutesCell.selectionStyle = .none
        return minutesCell
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.contentSize.height <= 30{
            inputMinuteTextHeight.constant = 30
        }
        else if textView.contentSize.height >= 100{
            inputMinuteTextHeight.constant = 100
        }
        else{
            inputMinuteTextHeight.constant = textView.contentSize.height
        }
    }
}
