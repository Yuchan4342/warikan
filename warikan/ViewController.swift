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
    
    @IBAction func tapCalculate(_ sender: Any) {
        var x1: Int = 0
        var x2: Int = 0
        let unit: Int = 100
        if let text = myTextField1.text, let x = Int(text) {
            x1 = x
            print("金額: ", x1)
        } else { return }
        if let text = myTextField2.text, let x = Int(text) {
            x2 = x
            print("人数: ", x2)
        } else { return }
        if (x2 == 0) { return }
        if (x1 % x2 == 0) {
            myLabel1.text = "一人" + String(x1 / x2) + "円！"
            print(myLabel1.text!)
        } else {
            let y1 = Int(floor(Double(x1 / x2 / unit))) * unit
            let y2 = x1 - y1 * x2;
            myLabel1.text = "一人" + String(y1) + "円で\n" + String(y2) + "円余ります。"
            print(myLabel1.text!)
//            let y3 = Int(ceil(Double(x1 / x2 / unit))) * unit
//            let y4 = x1 - y1 * x2;
//            myLabel1.text = "一人" + String(y3) + "円で\n" + String(y4) + "円足りません。"
        }
    }
    
    // myLabel1がタップされたときクリップボードにコピー
    @IBAction func pressLabel(_ sender: Any?) {
        guard let gesture = sender as? UIGestureRecognizer else { return }
        guard gesture.state == .ended else { return }
        guard let label = gesture.view as? UILabel else { return }
        UIPasteboard.general.string = label.text
        myLabel2.text = "Copied!"
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
        // myLabelのタップなどに反応可能とする
        myLabel1.isUserInteractionEnabled = true
        // 右揃えにする
        myTextField1.textAlignment = NSTextAlignment.right
        myTextField2.textAlignment = NSTextAlignment.right
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

