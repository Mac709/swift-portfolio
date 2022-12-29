//
//  ViewController.swift
//  bottum
//
//  Created by Daichi Koga on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var heighttextfield: UITextField!//interface builder
    @IBOutlet weak var weighttextfield: UITextField!
    @IBOutlet weak var BMIvalue: UILabel!
    
    override func viewDidLoad() {//画面を表示した時に呼ばれる
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heighttextfield.placeholder = "身長をcmで入力してください。"
        weighttextfield.placeholder = "体重をkgで入力してください。"
    }
    @IBAction func calcBMIbottum(_ sender: Any) {//actionをしたときに呼ばれる。紐付けかたも二種類ある。上に紐づけた場合は変数になる
        let doubleH = Double(heighttextfield.text!)
        let doubleW = Double(weighttextfield.text!)
        BMIvalue.text = calculation(height: doubleH!, weight: doubleW!)
    }
    
    func calculation(height: Double, weight: Double) -> String {
        let h = height / 100
        let w = weight
        var result = w/(h * h)
        result = floor(result*10)/10
        
        return result.description
    }

}

//command+shift+k は実行した際にマックのキーボードでアプリに入力可能となる。
//bottum (上紐付け)の名前変更 button.settitle("ボタン", for: . normal)
//bottum(上紐付け)の背景色変更buttom.backgroundColor = .red
//bottom(下紐付け)でラベル文字原稿label.textにより再定義すると切り替わる仕組みができる。
