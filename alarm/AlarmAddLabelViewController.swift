//
//  AlarmAddLabelViewController.swift
//  alarm
//
//  Created by nori nori on 2021/03/23.
//

import UIKit

protocol AlarmAddLabelDelegate {
    func alarmAddLabel(labelText:AlarmAddLabelViewController,text:String)
}

class AlarmAddLabelViewController: UIViewController,UITextFieldDelegate {
    
    var text:String!

    @IBOutlet weak var textField: UITextField!
    var delegate:AlarmAddLabelDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        // テキストを全消去するボタンを表示
        textField.clearButtonMode = .always
        // 改行ボタンの種類を設定
        textField.returnKeyType = .done
        // UITextFieldを追加
        textField.delegate = self
        //キーボードを表示する
        textField.becomeFirstResponder()
        
        textField.text = text
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //textFieldの中身が空でない時
        if textField.text != "", let text = textField.text{
            delegate.alarmAddLabel(labelText: self, text:text)
        }
    }
    
    // 完了ボタンを押した時の処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textFieldの中身が空でない時
        if textField.text != "", let text = textField.text{
            delegate.alarmAddLabel(labelText: self, text:text)
            self.navigationController?.popViewController(animated: true)
        }
        return true
    }
}

