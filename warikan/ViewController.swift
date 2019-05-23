//
//  ViewController.swift
//  warikan
//
//  Created by 岩田裕登 on 2017/05/30.
//  Copyright © 2017年 岩田裕登. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var myTextField1: UITextField!
    @IBOutlet weak var myTextField2: UITextField!
    @IBOutlet weak var myLabel1: UILabel!
    @IBOutlet weak var myLabel2: UILabel!
    @IBOutlet weak var myButton1: UIButton!
    
    @IBAction func tapCalculate(_ sender: Any) {
        guard let x1: Int = Int(self.myTextField1.text ?? "") else {
            print("Failed to convert textfield1 to Int")
            return
        }
        guard let x2: Int = Int(self.myTextField2.text ?? "") else {
            print("Failed to convert textfield2 to Int")
            return
        }
        print("金額: ", x1, "円, 人数: ", x2, "人")
        // 0 除算を防ぐ.
        if (x2 == 0) {
            print("Cannot divide by 0.")
            return
        }
        // x1 が x2 で割り切れる場合.
        if (x1 % x2 == 0) {
            self.myLabel1.text = "一人\(x1 / x2)円！"
            print(self.myLabel1.text ?? "")
        } else {
            // 一人あたりの金額を計算する時の単位.
            let unit: Int = 100
            let quotient: Double = Double(x1) / Double(x2)
            let y1: Int = Int(floor(quotient / Double(unit))) * unit
            let y2: Int = x1 - y1 * x2
            self.myLabel1.text = "一人\(y1)円で\n\(y2)円足りません。"
            print(self.myLabel1.text ?? "")
            let y3: Int = Int(ceil(quotient / Double(unit))) * unit
            let y4: Int = abs(x1 - y3 * x2)
            self.myLabel1.text = "一人\(y3)円で\n\(y4)円余ります。"
            print(self.myLabel1.text ?? "")
        }
    }
    
    // myLabel1がタップされたときクリップボードにコピー
    @IBAction func pressLabel(_ sender: Any?) {
        guard let gesture = sender as? UIGestureRecognizer else { return }
        guard gesture.state == .ended else { return }
        guard let label = gesture.view as? UILabel else { return }
        UIPasteboard.general.string = label.text
        self.myLabel2.text = "Copied!"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // 1.0秒後に実行したい処理
            self.myLabel2.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //
        self.myTextField1.delegate = self
        self.myTextField2.delegate = self
        // 人数の初期値を 2とする.
        self.myTextField2.text = "2"
        // myLabelのタップなどに反応可能とする
        self.myLabel1.isUserInteractionEnabled = true
        // 右揃えにする
        self.myTextField1.textAlignment = NSTextAlignment.right
        self.myTextField2.textAlignment = NSTextAlignment.right
        // ラベルのフォントサイズを動的に変更可能にする
        self.myLabel1.adjustsFontSizeToFitWidth = true
        // キーボードをテンキー入力にする
        self.myTextField1.keyboardType = UIKeyboardType.numberPad
        self.myTextField2.keyboardType = UIKeyboardType.numberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TextFieldが編集可能となったときの動作
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.perform(#selector(selectAll(_:)), with: nil, afterDelay: 0.05)
        return true
    }
    
    // TextField編集中にReturnが押されたときの動作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // フォーカスを外す
        textField.resignFirstResponder()
        // 次のTag番号を持っているテキストボックスがあれば、フォーカスする
        let nextTag = textField.tag + 1
        if let nextTextField = self.view.viewWithTag(nextTag) {
            nextTextField.becomeFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.myTextField1.isFirstResponder) {
            self.myTextField1.resignFirstResponder()
        }
        if (self.myTextField2.isFirstResponder) {
            self.myTextField2.resignFirstResponder()
        }
    }
}

